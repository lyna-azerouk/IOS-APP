//
//  ContentView.swift
//  Project
//
//  Created by Lina Azerouk on 25/10/2024.
//

import SwiftUI
import Foundation

struct ContentView: View {
  @StateObject var userAuthModel = UserAuthModel()

  var body: some View {

    Group {
      if userAuthModel.currentUser != nil && userAuthModel.userSession != "" {
        MainTabView()
        .environmentObject(userAuthModel)
      }else {
        WelcomePageView()
        .environmentObject(userAuthModel)
      }
    }
  }
}

#Preview {
    ContentView()
}
