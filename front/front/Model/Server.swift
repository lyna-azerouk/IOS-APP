
import Foundation

class Server {
  private var auth_request: AuthRequest
  private var response: Response
  private var request: URLRequest

  init(parameters: [String: String], url: String) {
    self.auth_request = AuthRequest(url: URL(string: AuthRequest.path + url)!, parameters: parameters)

    self.request = URLRequest(url: self.auth_request.url)
    self.request.setValue(self.auth_request.token, forHTTPHeaderField: "Authorization")
    self.request.setValue("application/json", forHTTPHeaderField: "Content-Type")

    self.response = Response(code: 0, message_code: "", content: "")
  }

  func execute(method: String) async -> Response {
    self.request.httpMethod = method

    do {
      self.request.httpBody = try JSONSerialization.data(withJSONObject: self.auth_request.parameters, options: [])
    } catch {
      print("Error encoding parameters: \(error.localizedDescription)")
      return Response(code: 500, message_code: "EncodingError", content: "Failed to encode parameters")
    }

    do {
      let (_, urlResponse) = try await URLSession.shared.data(for: self.request)
      if let httpResponse = urlResponse as? HTTPURLResponse {
        if httpResponse.statusCode == 200 {
          print("Status Code: \(httpResponse.statusCode)")
          self.response = Response(code: 200, message_code: "", content: "")
        } else {
          print("Réponse invalide ou non reconnue")
          self.response = Response(code: httpResponse.statusCode, message_code: "", content: "")
        }
      }
    } catch {
      print("Request failed with error: \(error.localizedDescription)")
    }

    return self.response
  }
}
