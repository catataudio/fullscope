import Apollo

final class GraphQLManager {
    static let shared = GraphQLManager()
    let client: ApolloClient

    private init() {
        let url = URL(string: "http://localhost:9999/graphql")!
        client = ApolloClient(url: url)
    }
}
