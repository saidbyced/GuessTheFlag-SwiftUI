//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Chris Eadie on 24/06/2020.
//  Copyright © 2020 ChrisEadieDesigns. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    @State private var correctAnswer = Int.random(in: 0...10)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    @State private var scoringAlertShowing = false
    @State private var score = 0
    @State private var totalQuestionCount = 0
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.secondary, .primary]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text("\(countries[correctAnswer])")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                        self.scoringAlertShowing = true
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 0.75))
                    }
                    .alert(isPresented: self.$scoringAlertShowing) {
                        Alert(title: Text(self.scoreTitle), message: Text(self.scoreMessage), dismissButton: .default(Text("Continue")) {
                            self.resetQuestion()
                        })
                    }
                }
                Text("You got \(self.score) right out of \(self.totalQuestionCount)")
                    .foregroundColor(.white)
                    .fontWeight(.medium)
                Spacer()
            }
        .padding(10)
        }
    }
    
    private func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            scoreMessage = "Your score is now \(score)"
        } else {
            scoreTitle = "Wrong-o"
            scoreMessage = "That's the flag of \(countries[number])!"
        }
        
        totalQuestionCount += 1
        showingScore = true
    }
    
    private func resetQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
