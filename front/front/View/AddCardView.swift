import SwiftUI
import SVGKit

struct AddCardView: View {
    @State private var selectedCardType = "Master Card"
    @State var selectedDate: Date = Date()
    @State var owner_name: String = ""
    @State var card_number: String = ""
    @State var csv: String = ""

    let cardTypes = ["Visa", "Mastercard", "American Express", "Discover"]
    private var costum_blue: Color = Color(UIColor(red: 64/255, green: 76/255, blue: 178/255, alpha: 1.0))
    private var color_gray: Color = Color(UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1.0))

    var body: some View {
      VStack {
        VStack(alignment: .leading, spacing: 20) {
          Text("Add new card | Edit card")
            .font(.headline)
            .foregroundColor(.black)

          AddCardTemplateView(cardType: selectedCardType)

          HStack {
            Picker(" Card Type", selection: $selectedCardType) {
              ForEach(cardTypes, id: \.self) { cardType in
                Text(cardType)
              }
            }
            .pickerStyle(MenuPickerStyle())
            .frame(width: 220, height: 40)
            .background(color_gray)
            .cornerRadius(10)
            .shadow(radius: 4, y: 4)

            HStack {
              DatePicker("Date", selection: $selectedDate, displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .frame(width: 0, height: 0)
            }
            .frame(width: 100, height: 40)
            .background(color_gray)
            .cornerRadius(10)
            .shadow(radius: 4, y: 4)
          }

          HStack {
            TextField(" Cardholder Name", text: $owner_name)
              .frame(width: 330, height: 40)
              .background(color_gray)
              .cornerRadius(10)
              .shadow(radius: 4, y: 4)
          }

          HStack (spacing: 10) {
            TextField(" Card Number", text: $card_number)
              .frame(width: 220, height: 40)
              .background(color_gray)
              .cornerRadius(10)
              .shadow(radius: 4, y: 4)

            TextField(" CSV", text: $csv)
              .frame(width: 100, height: 40)
              .background(color_gray)
              .cornerRadius(10)
              .shadow(radius: 4, y: 4)
          }

          Button("Add Card", action: {})
           .frame(maxWidth: 330, maxHeight: 40)
           .foregroundColor(.white)
           .background(costum_blue)
           .cornerRadius(10)
        }
        .frame(maxWidth: 370, maxHeight: 484)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 4, y: 4)

        Spacer()
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(Color(red: 0.9, green: 0.9, blue: 0.9))
      Spacer()
  }
}


struct AddCardTemplateView: View {
  let cardType: String

  var body: some View {

    VStack(alignment: .leading, spacing: 10) {
      Text("Avialable balance")
        .font(.caption)
        .foregroundColor(.white.opacity(0.7))

      Text(000000, format: .currency(code: "USD").presentation(.narrow))
        .font(.system(size: 34, weight: .bold))
        .foregroundColor(.white)

      Spacer()
      HStack {

      }
      Text("Expire " + "**/**")
        .foregroundColor(.white)
        .font(.body)
        .font(.system(size: 20, weight: .bold))

      HStack {
        Text("**** **** **** ****")
          .foregroundColor(.white)
          .font(.body)
          .font(.system(size: 20))
          Spacer()

        if cardType == "Mastercard" {
          Image(systemName: "circle.fill")
            .foregroundColor(.orange)
            .font(.system(size: 20))
          Image(systemName: "circle.fill")
            .foregroundColor(.red)
            .font(.system(size: 20))
        } else if cardType == "Visa" {
          Text("VISA")
            .foregroundColor(.white)
            .font(.headline)
            .font(.system(size: 40))
            .bold()
        }
      }
    }
    .padding()
    .frame(width: 330, height: 150)
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
