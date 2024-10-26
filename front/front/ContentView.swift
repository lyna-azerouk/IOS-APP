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

  var body: some View {
    NavigationStack {
      Form{
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
      }
      .navigationTitle("Authentification")
      .frame(width: 400, height: 200, alignment: .center)
    }
  }

  func submitForm() {
    guard let url = URL(string: "http://localhost:9292/users") else {
      print("invalid URL")
      return
    }

    var request = URLRequest(url: url)
    request.httpMethod = "POST"

    let parameters: [String: Any] = [
      "email": email,
      "password": password
    ]

    do {
      request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
    } catch {
      print("Error encoding parameters: \(error.localizedDescription)")
    }

    request.setValue("application/json", forHTTPHeaderField: "Content-Type")

    let task: URLSessionDataTask = URLSession.shared.dataTask(with: request) { data, response, error in
      if let error = error {
          print("Error: \(error.localizedDescription)")
          return
      }

      if let httpResponse = response as? HTTPURLResponse {
        if httpResponse.statusCode == 200 {
          print("Status Code: \(httpResponse.statusCode)")
        } else {
          print("Réponse invalide ou non reconnue")
        }
      }
    }

    task.resume()
  }
}

#Preview {
    ContentView()
}

