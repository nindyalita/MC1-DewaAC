//
//  Question.swift
//  Dewa AC
//
//  Created by Nindya Alita Rosalia on 08/04/23.
//

import Foundation

class Questions : ObservableObject{
    @Published var questions : [Question] = []
    
    init(){
        randomQuestions()
    }
    
    func randomQuestions(){
        questions = []
        var tempAnswers: [Int] = []
        
        for _ in 1...16 {
            var temp = generateOneQuestion()
            
            while tempAnswers.contains(temp.hasil){
                temp = generateOneQuestion()
            }
            tempAnswers.append(temp.hasil)
            let question = Question(soal: temp.soal, jawaban: temp.hasil)
            questions.append(question)
        }
    }
    
    private func generateOneQuestion() -> (soal: String, hasil: Int){
        var str = ""
        var hasil = 0
        let num1 = Int.random(in: 0...10)
        let num2 = Int.random(in: 0...10)
        
        str =  "\(num1) + \(num2)"
        
        hasil = num1 + num2
        
        return (str, hasil)
        
    }
}
