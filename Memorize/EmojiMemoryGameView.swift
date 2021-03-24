//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Allen Ding on 8/16/20.
//  Copyright © 2020 Allen Ding. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Button("New Game") {
                withAnimation(.easeInOut(duration: durationSpeed)) {
                    self.viewModel.createNewMemoryGameWithRandomTheme()
                }
            }
            Grid(viewModel.cards) {card in
                CardView(card: card).onTapGesture {
                    withAnimation(.linear(duration: durationSpeed)) {
                        self.viewModel.choose(card: card)
                    }
                }
                    .padding(5)
            }
                .padding()
                .foregroundColor(EmojiMemoryGame.chosenTheme.color)
            Text("Points: \(viewModel.points)")
                .font(Font.title)
                .foregroundColor(EmojiMemoryGame.chosenTheme.color)
        }
    }
    
    private let durationSpeed = 0.75
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
            .aspectRatio(2/3, contentMode: .fit)
    }
    
    @State private var animatedBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
        
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle.degrees(startingAngle), endAngle: Angle.degrees(-animatedBonusRemaining*360-90), clockwise: true)
                            .onAppear {
                                self.startBonusTimeAnimation()
                            }
                    } else {
                        Pie(startAngle: Angle.degrees(startingAngle), endAngle: Angle.degrees(-card.bonusRemaining*360-90), clockwise: true)
                    }
                }
                .padding(5)
                .opacity(0.5)
                .transition(.identity)
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
            }
            .cardify(isFaceUp: card.isFaceUp)
            .transition(AnyTransition.scale)
        }
    }
    
    // MARK:  - Drawing Constants
    private func fontSize(for size: CGSize) -> CGFloat{
        min(size.width, size.height) * 0.75
    }
    private let startingAngle = Double(0 - 90)
}

















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(viewModel: game)
    }
}
