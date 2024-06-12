//
//  ContentView.swift
//  Memorize
//
//  Created by Алексей Зубель on 20.05.24.
//

import SwiftUI



struct EmojiMemoryGameView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGame
    
    @State var emojis: Array<String> = []
        
    var body: some View {
        
        VStack{
            information
                .font(.system(size: 30))
            ScrollView {
                cards
                    .animation(.default, value: viewModel.cards)
            }
            .padding()
            Spacer()
            newGameButton
        }
    }
    
    var cards: some View{
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80), spacing: 0)], spacing: 0){
            ForEach(viewModel.cards){card in
                CardView(card, viewModel.themeColors)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card: card)
                    }
            }
        }
        .foregroundColor(viewModel.themeColors[0])
    }
    
    var information: some View{
        HStack{
            Text("\(viewModel.themeName)")
            Spacer().frame(width: 70)
            Text("Score: \(viewModel.gameScore)")
        }
    }
    
    var newGameButton: some View {
            Button(action: {
                viewModel.newGame()
            }, label: {
                VStack {
                    Image(systemName: "restart")
                        .font(.largeTitle)
                    Text("Start New Game!")
                        .font(.system(size: 20))
                }
            })
        }
}

struct CardView: View{
    let card: MemoryGame<String>.Card
    let gradientColors: Array<Color>
    
    init(_ card: MemoryGame<String>.Card, _ gradientColors: Array<Color>) {
        self.card = card
        self.gradientColors = gradientColors
    }
    
    var body: some View{
        ZStack{
            let base = RoundedRectangle(cornerRadius: 25.0)
            Group {
                base.fill(Color.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 100))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill(LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .topLeading, endPoint: .bottomTrailing)).opacity(card.isFaceUp ? 0 : 1)
        }
//        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
//        .onTapGesture {
//            isFaceUp = !isFaceUp
//        }
    }
    
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}

