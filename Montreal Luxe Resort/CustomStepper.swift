//
//  CustomStepper.swift
//  Montreal Luxe Resort
//
//  Created by Artur on 02.10.2024.
//

import SwiftUI

struct CustomStepper: View {
    @Binding var value: Int
       let range: ClosedRange<Int>
       
       var body: some View {
           HStack {
               Text("\(value)")
                   .font(.subheadline)
                   .foregroundColor(.white)
               Spacer()
               Button(action: {
                   if value > range.lowerBound {
                       value -= 1
                   }
               }) {
                   Text("-")
                       .font(.title)
                       .frame(width: 34, height: 34)
                       .background(Color("col1")) // Цвет фона кнопки
                       .foregroundColor(.white) // Цвет текста кнопки
                     
               }
               
             // Цвет текста
               
               Button(action: {
                   if value < range.upperBound {
                       value += 1
                   }
               }) {
                   Text("+")
                       .font(.title)
                       .frame(width: 34, height: 34)
                       .background(Color("col1"))// Цвет фона кнопки
                       .foregroundColor(.white) // Цвет текста кнопки
                      
               }
           }
           .padding()
        // Фон для всего Stepper
           .cornerRadius(10)
       }
   }


