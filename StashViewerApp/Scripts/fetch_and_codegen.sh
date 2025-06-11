#!/bin/bash
set -e

# Directory of this script
DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(cd "$DIR/.." && pwd)"

SCHEMA_PATH="$PROJECT_ROOT/GraphQL/schema.graphqls"
API_OUTPUT_DIR="$PROJECT_ROOT/GraphQL"

# Fetch schema from local Stash server
curl -o "$SCHEMA_PATH" http://localhost:9999/graphql/schema

# Run Apollo codegen
apollo-ios-cli generate \
  --schema "$SCHEMA_PATH" \
  --output "$API_OUTPUT_DIR" \
  --module-name API \
  "$PROJECT_ROOT/GraphQL"/*.graphql
