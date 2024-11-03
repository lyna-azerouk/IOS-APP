import SwiftUI

struct DashboardView: View {
  @State public var searchText: String = ""
  @EnvironmentObject var userAuthModel: UserAuthModel

  var body: some View {
    NavigationView {

      VStack {
        // First element of the page

        Text("Welcome \(userAuthModel.currentUser?.email ?? "")")
          .font(.title)
          .padding()

        HStack(spacing: 10) {
            Text("My cards")
              .font(.subheadline)
              .padding()
            Spacer()
            VStack {
              Image(systemName: "creditcard.fill")
              .resizable()
              .frame(width: 20, height: 20)

              NavigationLink(destination: CardsView()) {
                Text("Seel all")
              }
            }
        }
        .padding(16)
        .frame(maxWidth: 500)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .gray.opacity(0.2), radius: 8, x: 0, y: 2)

        // Second element of the page
        HStack(spacing: 10) {
            Text("My transactions")
              .font(.subheadline)
              .padding()
            Spacer()
            VStack {
              Image(systemName: "eurosign.arrow.trianglehead.counterclockwise.rotate.90")
              .resizable()
              .frame(width: 20, height: 20)

              NavigationLink(destination: CardsView()) {
                Text("Seel all")
              }
            }
        }
        .padding(16)
        .background(Color.white)
        .frame(maxWidth: 500)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .gray.opacity(0.2), radius: 8, x: 0, y: 2)

        Button(action: {
          UserDefaults.standard.set(false, forKey: "isLoggedIn")
          userAuthModel.currentUser = nil
          userAuthModel.userSession = ""
        }) {
          Text("Log out")
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(Color(red: 0.9, green: 0.9, blue: 0.9))
      .navigationTitle("Home Page")
      .searchable(text: $searchText)
    }
  }
}
