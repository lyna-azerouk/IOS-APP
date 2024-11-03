import SwiftUI

struct ProfileView: View {
  private var costum_blue: Color = Color(UIColor(red: 64/255, green: 76/255, blue: 178/255, alpha: 1.0))
  @EnvironmentObject var userAuthModel: UserAuthModel

  var body: some View {
    VStack(spacing: 20) {
      HStack {
        Image(systemName: "person.crop.circle.fill")
          .resizable()
          .frame(width: 80, height: 80)
          .clipShape(Circle())
          .overlay(
            Circle()
              .stroke(costum_blue, lineWidth: 2)
          )
          .padding(.bottom, 10)

        VStack(alignment: .leading) {
          Text("Hello,")
            .font(.subheadline)
            .foregroundColor(.secondary)
          Text("Daniel Akati")
            .font(.title3)
            .fontWeight(.bold)
          Text("\(userAuthModel.currentUser?.email ?? "")")
            .font(.subheadline)
            .foregroundColor(.secondary)
        }
        Spacer()
      }
      .padding()

      ProfileMenuItem(icon: "mappin.and.ellipse", title: "My Address")
      ProfileMenuItem(icon: "lock.fill", title: "Change Password")
      ProfileMenuItem(icon: "questionmark.circle.fill", title: "Help")
      ProfileMenuItem(icon: "list.bullet", title: "Privacy")
      ProfileMenuItem(icon: "clock.fill", title: "History")
      ProfileMenuItem(icon: "doc.text.fill", title: "Receipt")
      ProfileMenuItem(icon: "arrowshape.turn.up.left.fill", title: "Log Out")

      Spacer()
    }
    .padding()
    .background(Color(.systemGroupedBackground))
  }
}

struct ProfileMenuItem: View {
  var icon: String
  var title: String
  var costum_blue: Color = Color(UIColor(red: 64/255, green: 76/255, blue: 178/255, alpha: 1.0))

  var body: some View {
    HStack {
      Image(systemName: icon)
        .foregroundColor(.white)
        .frame(width: 30, height: 20)
        .background(costum_blue)
        .cornerRadius(10)

      Text(title)
        .font(.body)
        .foregroundColor(Color.white)

      Spacer()

      Image(systemName: "chevron.down")
        .foregroundColor(Color.white)
    }
    .padding()
    .background(costum_blue)
    .cornerRadius(8)
    .foregroundColor(.white)
  }
}

struct ProfileView_Previews: PreviewProvider {
  static var previews: some View {
    ProfileView()
  }
}
