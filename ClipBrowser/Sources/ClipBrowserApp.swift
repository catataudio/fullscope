import SwiftUI
import Apollo

@main
struct ClipBrowserApp: App {
    var body: some Scene {
        WindowGroup {
            SceneListView()
        }
    }
}

struct SceneListView: View {
    @State private var scenes: [Scene] = []
    @State private var loadingError: Error?

    var body: some View {
        NavigationView {
            List(scenes) { scene in
                Text(scene.title)
            }
            .navigationTitle("Scenes")
            .task {
                await loadScenes()
            }
        }
        .alert("Error", isPresented: .constant(loadingError != nil)) {
            Button("OK") { loadingError = nil }
        } message: {
            Text(loadingError?.localizedDescription ?? "Unknown error")
        }
    }

    func loadScenes() async {
        let client = ApolloClient(url: URL(string: "http://localhost:9999/graphql")!)
        do {
            let result = try await client.fetch(query: ScenesQuery())
            scenes = result.data?.scenes.map { Scene(id: $0.id, title: $0.title) } ?? []
        } catch {
            loadingError = error
        }
    }
}

struct Scene: Identifiable {
    let id: String
    let title: String
}

struct ScenesQuery: GraphQLQuery {
    static let operationDefinition: String = """
    query ScenesQuery {
        scenes {
            id
            title
        }
    }
    """

    static let operationName: String = "ScenesQuery"

    struct Data: GraphQLSelectionSet {
        static let selections: [GraphQLSelection] = [
            GraphQLField("scenes", type: .nonNull(.list(.nonNull(.object(Scene.selections)))))
        ]

        var resultMap: ResultMap

        var scenes: [Scene] {
            get { (resultMap["scenes"] as? [ResultMap])?.map { Scene(resultMap: $0) } ?? [] }
            set { resultMap.updateValue(newValue.map { $0.resultMap }, forKey: "scenes") }
        }

        struct Scene: GraphQLSelectionSet {
            static let selections: [GraphQLSelection] = [
                GraphQLField("id", type: .nonNull(.scalar(String.self))),
                GraphQLField("title", type: .nonNull(.scalar(String.self)))
            ]

            var resultMap: ResultMap

            var id: String { resultMap["id"]! as! String }
            var title: String { resultMap["title"]! as! String }
        }
    }
}
