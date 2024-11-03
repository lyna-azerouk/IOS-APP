
import Foundation
import SwiftUI
import Combine

class Server: ObservableObject {
  private var auth_request: AuthRequest
  private var response: Response
  private var request: URLRequest
  private var userAuthModel: UserAuthModel


  init(parameters: [String: String], url: String, userAuthModel: UserAuthModel) {
    self.auth_request = AuthRequest(url: URL(string: AuthRequest.path + url)!, parameters: parameters)

    self.request = URLRequest(url: self.auth_request.url)
    self.request.setValue(self.auth_request.token, forHTTPHeaderField: "Authorization")
    self.request.setValue("application/json", forHTTPHeaderField: "Content-Type")

    self.response = Response(code: 0, message_code: "")
    self.userAuthModel = userAuthModel
  }

  func execute(method: String) async -> Response {
    self.request.httpMethod = method

    do {
      self.request.httpBody = try JSONSerialization.data(withJSONObject: self.auth_request.parameters, options: [])
    } catch {
      print("Error encoding parameters: \(error.localizedDescription)")
        return Response(code: 500, message_code: "EncodingError")
    }

    do {
      let (data, urlResponse) = try await URLSession.shared.data(for: self.request)
      if let httpResponse = urlResponse as? HTTPURLResponse {
        if httpResponse.statusCode == 200 {
          print("Status Code: \(httpResponse.statusCode)")

          guard var content = String(data: data, encoding: .utf8) else {
            return Response(code: httpResponse.statusCode, message_code: "")
          }
          content = content.replacingOccurrences(of: "=>", with: ":")
          content = content.replacingOccurrences(of: "nil", with: "null")

          guard let jsonData = content.data(using: .utf8) else {
            return Response(code: httpResponse.statusCode, message_code: "")
          }

          let json = try JSONSerialization.jsonObject(with: jsonData, options: [])
          let user = try JSONDecoder().decode(User.self, from: jsonData)
          self.userAuthModel.currentUser = user
          self.userAuthModel.userSession = user.session_token

          self.response = Response(code: 200, message_code: "")
        } else {
          print("Réponse invalide ou non reconnue")
          self.response = Response(code: httpResponse.statusCode, message_code: "")
        }
      }
    } catch {
      print("Request failed with error: \(error.localizedDescription)")
    }

    return self.response
  }
}
