//
//  Question.swift
//  Dewa AC
//
//  Created by Nindya Alita Rosalia on 08/04/23.
//

import Foundation


class Question : ObservableObject{
    var id = UUID().uuidString
    let soal : String
    let jawaban: Int
    @Published var isShowing : Bool
    
    init(id: String = UUID().uuidString, soal: String, jawaban: Int, isShowing: Bool = true) {
        self.id = id
        self.soal = soal
        self.jawaban = jawaban
        self.isShowing = isShowing
    }
}
