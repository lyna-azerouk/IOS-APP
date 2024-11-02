import SwiftUI
import Foundation


struct CardsView: View {
	  @State private var cards = [
      Card(cardNumber: "**** **** **** 1234", holderName: "Alice Dupont", expiryDate: "12/24", balance: 100, cardType: "Visa"),
      Card(cardNumber: "**** **** **** 5678", holderName: "Bob Martin", expiryDate: "05/23", balance: 100, cardType: "Mastercard"),
      Card(cardNumber: "**** **** **** 9101", holderName: "Charlie Durant", expiryDate: "08/25", balance: 100, cardType: "MasterCard")
    ]

	@State private var currentIndex = 0

	var body: some View {
    VStack {
      HStack {
        Text("Cards")
          .font(.largeTitle)
          .bold()

        Spacer()

        Button(action: {
          var newCard = Card(cardNumber: "**** **** **** 1234", holderName: "Alice Dupont", expiryDate: "12/24", balance: 100, cardType: "Visa")
          cards.append(newCard)
          currentIndex = cards.count - 1
        }) {
          Image(systemName: "plus.circle.fill")
            .foregroundColor(.black)
            .font(.system(size: 30))
        }
      }
      .padding()

      CardView(card: cards[currentIndex]).animation(.spring())

      HStack(spacing: 8) {
        ForEach(0..<cards.count) { index in
          Circle()
            .fill(index == currentIndex ? Color.blue : Color.gray)
            .frame(width: 10, height: 10)
        }
      }
      .padding(.bottom, 2)

      HStack(spacing: 200) {
        Button(action: {
          currentIndex = (currentIndex - 1) % cards.count
        }) {
          Image(systemName: "arrow.left.circle.fill")
            .foregroundColor(.black)
            .font(.system(size: 30))
        }

        Button(action: {
          currentIndex = (currentIndex + 1) % cards.count
        }) {
          Image(systemName: "arrow.right.circle.fill")
            .foregroundColor(.black)
            .font(.system(size: 30))
        }
     }

     Spacer()

      //Income and apending for this card
      VStack (alignment: .leading, spacing: 10) {
        HStack {
          Text("This week")
            .font(.system(size: 20))
            .foregroundColor(Color(UIColor(red: 64/255, green: 76/255, blue: 178/255, alpha: 1.0)))
            .bold()
            .padding()
        }
        .frame(height: 35)
        .background(Color(UIColor(red: 233/255, green: 236/255, blue: 240/255, alpha: 1.0)))
        .shadow(radius: 10)
        .cornerRadius(15)
        .padding([.top, .leading])

        Spacer()

        HStack{
          Image(systemName: "arrow.up.circle.fill")
            .foregroundColor(.green)
            .font(.system(size: 60))

          VStack(alignment: .leading) {
            Text("Income")
              .foregroundColor(Color(UIColor(red: 64/255, green: 76/255, blue: 178/255, alpha: 1.0)))
              .font(.system(size: 20))
              .font(.body)

            Text(100, format: .currency(code: "USD").presentation(.narrow))
              .font(.system(size: 22))
              .font(.body)
              .bold()
          }
          Spacer()

          Image(systemName: "arrow.down.circle.fill")
            .foregroundColor(.red)
            .font(.system(size: 60))

          VStack(alignment: .leading) {
            Text("Spending")
              .foregroundColor(Color(UIColor(red: 64/255, green: 76/255, blue: 178/255, alpha: 1.0)))
              .font(.system(size: 20))
              .font(.body)

            Text(100, format: .currency(code: "USD").presentation(.narrow))
              .font(.system(size: 22))
              .font(.body)
              .bold()
          }
        }
        .padding()

        //Show chart button
        VStack(spacing: 5) {
          Rectangle()
            .fill(Color.gray)
            .frame(height: 1)
            .frame(maxWidth: .infinity)

          Button(action: {
            print("Show Chart")
          }) {
          Text("Show Chart")
            .frame(alignment: .center)
            .font(.system(size: 20))
            .foregroundColor(Color(UIColor(red: 64/255, green: 76/255, blue: 178/255, alpha: 1.0)))
            .bold()
            .padding()
          }
        }
      }
      .frame(width: 370, height: 250)
      .background(Color.white)
      .cornerRadius(15)
      .shadow(radius: 5)
      .padding(.bottom, 80)
      Spacer()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color(red: 0.9, green: 0.9, blue: 0.9))
	}

  func formatCurrency(_ amount: Double) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.currencySymbol = "$" // Customize currency symbol if needed
    formatter.maximumFractionDigits = 2
    return formatter.string(from: NSNumber(value: amount)) ?? ""
  }
}


struct CardView: View {
    let card: Card

    var body: some View {

      VStack(alignment: .leading, spacing: 10) {
        Text("Avialable balance")
          .font(.caption)
          .foregroundColor(.white.opacity(0.7))

        Text(card.balance, format: .currency(code: "USD").presentation(.narrow))
          .font(.system(size: 34, weight: .bold))
          .foregroundColor(.white)

        Spacer()

        Text("Expire " + card.expiryDate)
          .foregroundColor(.white)
          .font(.body)
          .font(.system(size: 20, weight: .bold))

        HStack {
          Text(card.cardNumber)
            .foregroundColor(.white)
            .font(.body)
            .font(.system(size: 20))
            Spacer()

          if card.cardType == "Mastercard" {
            Image(systemName: "circle.fill")
              .foregroundColor(.orange)
              .font(.system(size: 20))
            Image(systemName: "circle.fill")
              .foregroundColor(.red)
              .font(.system(size: 20))
          } else if card.cardType == "Visa" {
            Text("VISA")
              .foregroundColor(.white)
              .font(.headline)
              .font(.system(size: 40))
              .bold()
          }
        }
      }
      .padding()
      .frame(width: 350, height: 200)
      .background(
        LinearGradient(
          gradient: Gradient(colors: [Color.blue, Color.purple]),
          startPoint: .topLeading,
          endPoint: .bottomTrailing
        )
      )
      .cornerRadius(15)
      .shadow(radius: 5)
    }
}
