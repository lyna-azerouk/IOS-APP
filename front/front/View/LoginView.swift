import SwiftUI
import Foundation

struct LoginView: View {
  @State private var email: String = ""
  @State private var password: String = ""
  @State private var navigateToProfile = false
  @EnvironmentObject var userAuthModel: UserAuthModel
  private var costum_blue: Color = Color(UIColor(red: 64/255, green: 76/255, blue: 178/255, alpha: 1.0))

  var body: some View {
    NavigationStack {
      VStack(spacing: 20) {
        Text("Welcome back")
          .font(.title)
          .fontWeight(.bold)

        Text("Please enter your details")
          .font(.subheadline)
          .foregroundColor(.gray)

        VStack(spacing: 16) {
          TextField("Email", text: $email)
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.5)))

          SecureField("Password", text: $password)
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.5)))
          }
          .padding(.horizontal, 10)

          // Submit Button
          Button(action: submitForm) {
            Text("Submit")
              .frame(maxWidth: .infinity, maxHeight: 15)
              .padding()
              .background(costum_blue)
              .foregroundColor(.white)
              .cornerRadius(10)
          }
          .padding(.horizontal, 10)

          NavigationLink(destination: MainTabView(), isActive: $navigateToProfile) {
            EmptyView()
          }
      }
      .padding()
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
