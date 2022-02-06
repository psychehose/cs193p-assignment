//
//  ContentView.swift
//  cs193p_assignment
//
//  Created by 김호세 on 2022/02/05.
//

import SwiftUI

struct ContentView: View {
    var emotions = ["😄","😃","😀","😁","😆","😅","😂","🤣","🥲","☺️"]
    var vehicles = ["🚗","🚕","🚌","🚎","🏎","🚓","🚑","🚒","🚐","🛻"]
    var food = ["🍏","🍎","🍐","🍊","🍋","🍌","🍉","🍇","🍓","🫐"]

    @State var emojisCount: Int = 0
    @State var cardCount: Int = 10
    @State var typeState: Int = 0 {
        didSet {
            if typeState == 0 {
                resultArray = emotions.shuffled()
            }
            if typeState == 1 {
                resultArray = vehicles.shuffled()
            }
            if typeState == 2 {
                resultArray = food.shuffled()
            }
        }
    }

    @State var resultArray: [String] = []
    
    
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                Text("Memorize!")
                    .font(.largeTitle)
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))]) {
                    
                    ForEach(resultArray[0 ..< resultArray.count], id: \.self) { ele in
                        CardView(content: ele)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            Spacer()
            HStack {
                emoButton
                vehicleButton
                foodButton
            }
            
        }
        .padding()
    }

    var emoButton: some View {
        TypeButton(action: {
            typeState = 0
        },
                   image: Image(systemName: "face.smiling"),
                   content: "Emotions")
    }
    var vehicleButton: some View {
        TypeButton(action: {
            typeState = 1
        },
                   image: Image(systemName: "car"),
                   content: "Emotions")
    }
    var foodButton: some View {
        TypeButton(action: {
            typeState = 2
        },
                   image: Image(systemName: "hare"),
                   content: "Emotions")
    }
           

}

struct CardView: View {
    @State var isFaceUp: Bool = true
    var content: String

    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}
struct TypeButton: View {
    var action: () -> ()
    var image: Image
    var content: String
    var body: some View {
        Button (action: action, label: {
            VStack {
                image
                Text(content)
                    .font(.body)
            }
            .font(.largeTitle)
            .padding()
        })
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
