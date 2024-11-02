import SwiftUI

struct MainTabView: View {
  init() {
      UITabBar.appearance().backgroundColor = UIColor.white
      UITabBar.appearance().isTranslucent = true
  }

  var body: some View {
    ZStack {
      TabView {
        DashboardView()
        .tabItem {
          VStack {
            Image(systemName: "house.fill")
            Text("Dashboard")
          }
        }

        AddCardView()
        .tabItem {
          VStack {
            Image(systemName: "plus.circle.fill")
            Text("Add Cards")
          }
        }

        CardsView()
        .tabItem {
          VStack {
            Image(systemName: "wallet.pass.fill")
            Text("Wallets")
          }
        }

        ProfileView()
        .tabItem {
          VStack {
            Image(systemName: "person.circle.fill")
            Text("My Profile")
          }
        }
      }
      .accentColor(Color(UIColor(red: 64/255, green: 76/255, blue: 178/255, alpha: 1.0)))
      .shadow(radius: 5)
    }
  }
}

struct ProfileView: View {
  var body: some View {
    VStack {
      Text("My Profile")
        .font(.largeTitle)
        .padding()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
      ContentView()
  }
}
