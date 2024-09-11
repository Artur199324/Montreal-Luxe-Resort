//
//  Questions.swift
//  Montreal Luxe Resort
//
//  Created by Artur on 11.09.2024.
//

import Foundation

struct Questions{
    
    static let questions = [
    "When was the Montreal Casino officially opened?",
    "Which of these is a feature of the Montreal Casino?",
    "Where is the Montreal Casino located?",
    "The Montreal Casino is housed in how many connected buildings?",
    
    "Which type of game is NOT available at the Montreal Casino?",
    
    "Which of the following describes the architectural design of the Montreal Casino?",
    
    "What is the legal gambling age at the Montreal Casino?",
    
    "The Montreal Casino is operated by which organization?",
    
    "How many restaurants does the Montreal Casino have?",
    "What was the former purpose of one of the casino’s buildings, the French Pavilion?",
    "The Montreal Casino is known for having no what?",
    "TWhich of these activities can you do at the Montreal Casino besides gambling?"
    
    ]
    
    static var wordAnswer: [[String]] = [
        ["1983", "1993", "2001", "2008"],
        ["It has a water park", "It is located on a cruise ship", "It has five floors", "It is made entirely of glass"],
        ["Downtown Montreal", "Parc Jean-Drapeau", "Old Montreal", "Mount Royal"],
        ["One", "Two", "Three", "Four"],
        
        ["Poker", "Slot machines", "Baccarat", "Keno"],
        
        ["Circular with domes", "Rectangular with glass facades", "Modern with an irregular shape", "Gothic with spires"],
        
        ["18 years", "19 years", "20 years", "21 years"],
        
        ["Government of Quebec", "Loto-Québec", "Casino Montreal Corporation", "International Gaming Association"],
        
        ["One", "Two", "Three", "Five"],
        ["A museum", "An airport terminal", "Part of Expo 67", "A concert hall"],
        ["No table games", "No clocks", "No restaurants", "No slot machines"],
        ["Skiing", "Attending live performances", "Ice skating", "Skydiving"]
    ]
    
    
    static var wrong = [2,3,2,2,4,3,4,2,3,3,2,2]
}
