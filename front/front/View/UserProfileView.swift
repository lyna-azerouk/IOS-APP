import SwiftUI

struct UserProfileView: View {
  @State public var searchText: String = ""

  var body: some View {
    NavigationView {

      VStack {
        // First element of the page
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
        Spacer()

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
        .frame(maxWidth: 500)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .gray.opacity(0.2), radius: 8, x: 0, y: 2)
        Spacer()
      }

      .navigationTitle("Home Page")
      .searchable(text: $searchText)
    }
  }
}
