import SwiftUI

struct WelcomePageView: View {
  @EnvironmentObject var userAuthModel: UserAuthModel

	var body: some View {
		NavigationView {
			VStack(spacing: 20) {
				Text("Bienvenue")
					.font(.largeTitle)
					.fontWeight(.bold)
					.padding(.bottom, 40)

				Text("Connectez-vous ou inscrivez-vous pour continuer")
					.font(.body)
					.multilineTextAlignment(.center)
					.padding(.horizontal, 30)

				Spacer()

				NavigationLink(destination: LoginView().environmentObject(userAuthModel)) {
					Text("Connexion")
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
				}
				.padding(.horizontal, 20)

				NavigationLink(destination: SignupView().environmentObject(userAuthModel)) {
					Text("Inscription")
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
				}
				.padding(.horizontal, 20)

				Spacer()
			}
			.navigationBarHidden(true)
		}
	}
}
