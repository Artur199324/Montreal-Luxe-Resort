import Foundation
class CommentsManager: ObservableObject {
    @Published var commentsByCategory: [String: [Comment]] = [:]

    init() {
        loadComments()
    }
    
    func addComment(for category: String, name: String, message: String) {
        let newComment = Comment(id: UUID(), name: name, message: message)
        if commentsByCategory[category] == nil {
            commentsByCategory[category] = []
        }
        commentsByCategory[category]?.append(newComment)
        saveComments()
    }
    
    func getComments(for category: String) -> [Comment] {
        return commentsByCategory[category] ?? []
    }
    
    private func saveComments() {
        if let encoded = try? JSONEncoder().encode(commentsByCategory) {
            UserDefaults.standard.set(encoded, forKey: "commentsByCategory")
        }
    }
    
    private func loadComments() {
        if let savedData = UserDefaults.standard.data(forKey: "commentsByCategory"),
           let decoded = try? JSONDecoder().decode([String: [Comment]].self, from: savedData) {
            commentsByCategory = decoded
        }
    }
}
