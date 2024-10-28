import Foundation

struct AuthRequest: Codable {
  static var path: String = "http://localhost:9292"
  var url: URL
  var token: String = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJkYXRhIjoidG9rZW4ifQ.xOK4BlpbIxwBpWs9YYxVjKzaGZYHpbwj9TQaryk888c"
  var parameters: [String: String]
}

