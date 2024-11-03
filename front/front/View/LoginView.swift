import SwiftUI
import Foundation

struct LoginView: View {
  @State private var email: String = ""
  @State private var password: String = ""
  @State private var navigateToProfile = false
  @EnvironmentObject var userAuthModel: UserAuthModel

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
      }
      .navigationTitle("Login")
      .frame(width: 400, height: 200, alignment: .center)

        NavigationLink(destination: MainTabView(), isActive: $navigateToProfile) {
        EmptyView()
      }
    }
  }

  func submitForm() {
    let parameters: [String: String] = [
      "email": email,
      "password": password
    ]

      let server = Server(parameters: parameters, url: "/users/login", userAuthModel: userAuthModel)

    Task {
      let response = try await server.execute(method: "POST")

      if response.code == 200 {
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
        self.navigateToProfile = true
      }
    }
  }
}
