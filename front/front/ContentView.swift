//
//  ContentView.swift
//  Project
//
//  Created by Lina Azerouk on 25/10/2024.
//

import SwiftUI
import Foundation

struct ContentView: View {
  @State private var email: String = ""
  @State private var password: String = ""
  @State private var navigateToProfile = false

  var body: some View {
    NavigationStack {
      Form {
        TextField("Email", text: $email)
        TextField("Password", text: $password)

        Button(action: submitForm) {
          Text("Submit")
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding(.top)

        NavigationLink(destination: UserProfileView(), isActive: $navigateToProfile) {
          EmptyView()
        }
      }
      .navigationTitle("Authentifiation")
      .frame(width: 400, height: 200, alignment: .center)
    }
  }

  func submitForm() {
    let parameters: [String: Any] = [
      "email": email,
      "password": password
    ]

    let server = Server(parameters: parameters, url: "/users")
    Task {
      let response = try await server.execute(method: "POST")
      if response.code == 200 {
        self.navigateToProfile = true
      }
    }
  }
}


#Preview {
    ContentView()
}

protocol Request {
  var path: String { get set }
  var token: String { get set }
  var parameters: [String: Any] { get set }
}


struct AuthRequest: Request {
  var path: String = "http://localhost:9292"
  var token: String = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJkYXRhIjoidG9rZW4ifQ.xOK4BlpbIxwBpWs9YYxVjKzaGZYHpbwj9TQaryk888c"
  var parameters: [String: Any]
}

struct Response {
  var code: Int
  var message_code: String
  var content: String
}

class Server {
  private var auth_request: AuthRequest
  private var response: Response

  init(parameters: [String: Any], url: String) {
    self.auth_request = AuthRequest(parameters: parameters)
    self.auth_request.path = self.auth_request.path + url
    self.response = Response(code: 0, message_code: " ", content: " ")
  }

  func execute(method: String) async -> Response {
    let url = URL(string: self.auth_request.path)!

    var request: URLRequest = URLRequest(url: url)
    request.setValue(self.auth_request.token, forHTTPHeaderField: "Authorization")
    request.httpMethod = method

    do {
      request.httpBody = try JSONSerialization.data(withJSONObject: self.auth_request.parameters, options: [])
    } catch {
      print("Error encoding parameters: \(error.localizedDescription)")
    }

    request.setValue("application/json", forHTTPHeaderField: "Content-Type")

    let task: URLSessionDataTask = URLSession.shared.dataTask(with: request) { data, response, error in

      if let httpResponse = response as? HTTPURLResponse {
        if httpResponse.statusCode == 200 {
          print("Status Code: \(httpResponse.statusCode)")
          self.response = Response(code: 200, message_code: "***", content:  "fdkjfkdjf")
        } else {
          print("Réponse invalide ou non reconnue")
          self.response = Response(code: httpResponse.statusCode, message_code: "***", content:  "fdkjfkdjf")
        }
      }
    }

    task.resume()

    return self.response
  }
}