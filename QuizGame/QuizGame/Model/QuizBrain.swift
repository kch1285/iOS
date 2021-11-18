//
//  QuizBrain.swift
//  QuizGame
//
//  Created by chihoooon on 2021/11/18.
//

import Foundation

struct QuizBrain {
    var questionNumber = 0
    var score = 0
    
    let quiz = [
//        Question(text: "A slug's blood is green.", answer: "True"),
//        Question(text: "Approximately one quarter of human bones are in the feet.", answer: "True"),
//        Question(text: "The total surface area of two human lungs is approximately 70 square metres.", answer: "True"),
//        Question(text: "In West Virginia, USA, if you accidentally hit an animal with your car, you are free to take it home to eat.", answer: "True"),
//        Question(text: "In London, UK, if you happen to die in the House of Parliament, you are technically entitled to a state funeral, because the building is considered too sacred a place.", answer: "False"),
//        Question(text: "It is illegal to pee in the Ocean in Portugal.", answer: "True"),
//        Question(text: "You can lead a cow down stairs but not up stairs.", answer: "False"),
//        Question(text: "Google was originally called 'Backrub'.", answer: "True"),
//        Question(text: "Buzz Aldrin's mother's maiden name was 'Moon'.", answer: "True"),
//        Question(text: "The loudest sound produced by any animal is 188 decibels. That animal is the African Elephant.", answer: "False"),
//        Question(text: "No piece of square dry paper can be folded in half more than 7 times.", answer: "False"),
//        Question(text: "Chocolate affects a dog's heart and nervous system; a few ounces are enough to kill a small dog.", answer: "True")
        
        Question(text: "Which is the largest organ in the human body?", choice: ["Heart", "Skin", "Large Intestine"], answer: "Skin"),
        Question(text: "Five dollars is worth how many nickels?", choice: ["25", "50", "100"], answer: "100"),
        Question(text: "What do the letters in the GMT time zone stand for?", choice: ["Global Meridian Time", "Greenwich Mean Time", "General Median Time"], answer: "Greenwich Mean Time"),
        Question(text: "What is the French word for 'hat'?", choice: ["Chapeau", "Écharpe", "Bonnet"], answer: "Chapeau"),
        Question(text: "In past times, what would a gentleman keep in his fob pocket?", choice: ["Notebook", "Handkerchief", "Watch"], answer: "Watch"),
        Question(text: "How would one say goodbye in Spanish?", choice: ["Au Revoir", "Adiós", "Salir"], answer: "Adiós"),
        Question(text: "Which of these colours is NOT featured in the logo for Google?", choice: ["Green", "Orange", "Blue"], answer: "Orange"),
        Question(text: "What alcoholic drink is made from molasses?", choice: ["Rum", "Whisky", "Gin"], answer: "Rum"),
        Question(text: "What type of animal was Harambe?", choice: ["Panda", "Gorilla", "Crocodile"], answer: "Gorilla"),
        Question(text: "Where is Tasmania located?", choice: ["Indonesia", "Australia", "Scotland"], answer: "Australia")
    ]
    
    mutating func checkAnswer(_ userAnswer: String) -> Bool {
        if userAnswer == quiz[questionNumber].answer {
            score += 1
            return true
        }
        else {
            return false
        }
    }
    
    func getQuestionText() -> String {
        return quiz[questionNumber].text
    }
    
    func getProgress() -> Float {
        return Float(questionNumber + 1) / Float(quiz.count)
    }
    
    mutating func nextQuestion() {
        if questionNumber < quiz.count - 1 {
            questionNumber += 1
        }
        else {
            questionNumber = 0
            score = 0
        }
    }
    
    func getButtonTitle() -> [String] {
        return quiz[questionNumber].choice
    }
    
    func getScore() -> Int {
        return score
    }
}
