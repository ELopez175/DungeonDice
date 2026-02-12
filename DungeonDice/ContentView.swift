//
//  ContentView.swift
//  DungeonDice
//
//  Created by LOPEZ, EIBI on 2/6/26.
//

import SwiftUI

struct ContentView: View {
    enum Dice: Int, CaseIterable, Identifiable {
        
        case four = 4
        case six = 6
        case eight = 8
        case ten = 10
        case twelve = 12
        case twenty = 20
        case hundred = 100
        
        var id: Int { // one value computed properties (or functions) don't need return
             rawValue // Each rawValue is unique, so it's a good ID
        }
        
        var description: String { "\(rawValue)-sided"}
        
        func roll() -> Int {
            return Int.random(in: 1...self.rawValue)
        }
    }
    
    @State private var resultmessage = ""
    @State private var animationTrigger = false // changed when animation occured
    @State private var isDoneAnimating = true
    var body: some View {
        VStack {
            Text("Dungeon Dice")
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundColor(.red)
            
            Spacer()
            
            Text(resultmessage)
                .font(.largeTitle)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .rotation3DEffect(isDoneAnimating ? .degrees(360) : .degrees(0), axis: (x: 1, y: 0, z: 0)) // one full rotation on x-axis only
                .frame(height: 150)
                .onChange(of: animationTrigger) {
                    isDoneAnimating = false // set beginning "flse" state right away
                    withAnimation(.interpolatingSpring(duration: 0.6, bounce: 0.4)) {
                        isDoneAnimating = true
                    }
                }
            
            Spacer()
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100, maximum: 102))]) {
                ForEach(Dice.allCases) { dice in
                    Button(dice.description) {
                        resultmessage = "You rolled a \(dice.roll()) on a \(dice.rawValue)-sided dice"
                        animationTrigger.toggle() // a change of this valu triggers an animation
            }
            
           
                }
            }
            .buttonStyle(.borderedProminent)
            .tint(.red)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
