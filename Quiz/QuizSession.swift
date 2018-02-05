//
//  QuizSession.swift
//  Quiz
//
//  Created by Pascal Hurni on 17.02.16.
//  Copyright (c) 2016 Pascal Hurni. All rights reserved.
//

import Foundation

class QuizSession {
    
    fileprivate var questions: [Question]
    fileprivate var currentIndex: Int
    private var _score: Int
    
    var score: Int {
        get { return _score}
    }
    
    var questionCount: Int {
        get {
            return questions.count
        }
    }
    
    init() {
        questions = [
            Question(
                caption: "2+2",
                answers: ["1", "2", "4"],
                correctAnswer: "4"),
            Question(
                caption: "Meaning of life?",
                answers: ["God", "42", "Me"],
                correctAnswer: "42"),
            Question(
                caption: "May the Force be with you",
                answers: ["Star wars", "Forest Gump", "American pie"],
                correctAnswer: "Star wars")
        ]
        
        currentIndex = -1
        _score = 0
    }
    
    func nextQuestion() -> Question? {
        if currentIndex+1 >= questions.count {
            return nil
        }
        else {
            currentIndex += 1
            return questions[currentIndex]
        }
    }
    
    func checkAnswer(_ answer: String) -> Bool {
        if questions[currentIndex].isCorrectAnswer(answer) {
            _score += 1
            return true
        }
        return false
    }
}
