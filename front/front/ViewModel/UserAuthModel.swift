import Foundation

class UserAuthModel: ObservableObject{
  static let shared: UserAuthModel = UserAuthModel()

  @Published var userSession: String {
    didSet {
      UserDefaults.standard.set(userSession, forKey: "userSession")
    }
  }

  @Published var currentUser: User?

  init() {
    self.userSession = UserDefaults.standard.string(forKey: "userSession")!
    Task {
      await getUserBySessionToken()
    }
  }


  private func getUserBySessionToken() async {
    print("getUserBySessionToken")
    print(self.userSession)

    let parameters: [String: String]  = ["session_token": self.userSession]

    let server = Server(parameters: parameters, url: "/users/session_token", userAuthModel: self )
    let response = try await server.execute(method: "GET")

    if response.code == 200 {
      print ("User found")
        self.currentUser = User(email: "fdfdf", password: "fdsfdf", session_token: "sderer")
    }else {
      print ("User not found")
      self.currentUser = nil
      self.userSession = ""
    }
  }
}
