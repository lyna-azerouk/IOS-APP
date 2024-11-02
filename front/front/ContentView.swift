//
//  ContentView.swift
//  Project
//
//  Created by Lina Azerouk on 25/10/2024.
//

import SwiftUI
import Foundation

struct ContentView: View {
  var body: some View {

    Group {
      let isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")

      if false {
        UserProfileView()
      }else {
          CardsView()
      }
    }
  }
}

#Preview {
    ContentView()
}
