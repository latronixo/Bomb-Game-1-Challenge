//
//  GameBrain.swift
//  FirstChallengeGameBomb
//
//  Created by Валентин latronixo on 09.02.2025.
//

import Foundation

struct GameBrain {
    
    let questions = [
        Question(text: "Назовите вид зимнего спорта", category: "O Разном"),
        Question(text: "Назовите вид зимнего спорта", category: "Спорт и Хобби"),
        Question(text: "Назовите вид зимнего спорта", category: "Про Жизнь")
    ]
    
    var questionNumber = 0
    
    func getQuestionText() -> String {
        return questions[questionNumber].text
    }
}
