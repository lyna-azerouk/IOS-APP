
import Foundation

class Server {
  private var auth_request: AuthRequest
  private var response: Response

  init(parameters: [String: String], url: String) {
    self.auth_request = AuthRequest(parameters: parameters)
    self.auth_request.path = self.auth_request.path + url
    self.response = Response(code: 0, message_code: "", content: "")
  }

  func execute(method: String) async -> Response {
    let url = URL(string: self.auth_request.path)!
    var request = URLRequest(url: url)
    request.setValue(self.auth_request.token, forHTTPHeaderField: "Authorization")
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpMethod = method

    do {
      request.httpBody = try JSONSerialization.data(withJSONObject: self.auth_request.parameters, options: [])
    } catch {
      print("Error encoding parameters: \(error.localizedDescription)")
      return Response(code: 500, message_code: "EncodingError", content: "Failed to encode parameters")
    }

    do {
      let (data, urlResponse) = try await URLSession.shared.data(for: request)
      if let httpResponse = urlResponse as? HTTPURLResponse {
        if httpResponse.statusCode == 200 {
          print("Status Code: \(httpResponse.statusCode)")
          self.response = Response(code: 200, message_code: "***", content: "fdkjfkdjf")
        } else {
          print("Réponse invalide ou non reconnue")
          self.response = Response(code: httpResponse.statusCode, message_code: "***", content: "fdkjfkdjf")
        }
      }
    } catch {
      print("Request failed with error: \(error.localizedDescription)")
    }

    return self.response
  }
}
