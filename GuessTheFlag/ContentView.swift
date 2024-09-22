//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Bahar Atbaş on 16.09.2024.
//

import SwiftUI

struct ContentView: View {
    //countries bulunduran bir array olacak. dizideki shuffled()-> diziyi karıştırır.
    //ve random bir şey oluşturması için bir değişken tamınlıycaz
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var allerMessage = ""
    @State private var showingAlert = false
    @State private var score = 0
    @State private var tapCount = 0
    @State private var gameOver = false
    
    var body: some View {
       
        ZStack{
            
            /*LinearGradient(colors: [.white,.brown], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()*/
           /* RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 300, endRadius: 400)
                .ignoresSafeArea()*/
            RadialGradient(stops: [
                .init(color: .black, location: 0.26),
                .init(color: .gray, location: 0.3),
            ], center: .top, startRadius: 170, endRadius: 700)
                .ignoresSafeArea()
        
            VStack(spacing: 30) {
                
                VStack{
                    
                    Image(systemName: "flag.2.crossed.fill")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .bold()
                    Text("Tap The Flag Of")
                        .foregroundStyle(.white)
                        .font(.largeTitle)
                        .bold()
                    Text(countries[correctAnswer])
                        .foregroundStyle(.white)
                        .font(.title)
                }
                .padding()
                
                ForEach(0..<3) { number in
                    
                    Button{
                        if number == correctAnswer{
                            allerMessage = "Succesfull"
                            score += 1
                            
                        }else{
                            allerMessage = "Wrong!"
                            score -= 1
                            
                        }
                        tapCount += 1
                        showingAlert = true
                        
                        if tapCount >= 10{
                            gameOver = true
                        }
                        
                    } label: {
                        Image(countries[number])
                            .clipShape(.capsule)
                            .shadow(radius: 9)
                    }
                }
                .alert(allerMessage, isPresented: $showingAlert) {
                            Button("Devam", action: askQuestion)
                        } message: {
                            Text("Skorun \(score)")
                        }
                        .alert("Oyun Bitti", isPresented: $gameOver) {
                                            Button("Yenile", action: resetGame)
                        } message: {
                            Text("Toplam Skorun :  \(score)")}
                }
            }
        }
    func askQuestion() {
          // Yeni soru veya oyunun devamı için yapılacak işlemler
        countries = countries.shuffled()
        correctAnswer = Int.random(in: 0...2)
    print("Yeni soruya geçiliyor...")
          
      }
    func resetGame(){
        score = 0
        tapCount = 0
        askQuestion()
    }
}
#Preview {
    ContentView()
}
