//
//  RotatingProgressBar.swift
//  Montreal Luxe Resort
//
//  Created by Artur on 03.10.2024.
//

import SwiftUI

struct RotatingProgressBar: View {
    @State private var isAnimating = false  // Статус анимации

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 10)
                .opacity(0.3)
                .foregroundColor(.white)  // Прозрачный круг
            
            Circle()
                .trim(from: 0, to: 0.3)  // Показываем часть круга
                .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round))
                .foregroundColor(.white)  // Белый прогресс
                .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))  // Вращение
                .animation(Animation.linear(duration: 1.0).repeatForever(autoreverses: false), value: isAnimating)
        }
        .frame(width: 30, height: 30)  // Размер индикатора
        .onAppear {
            isAnimating = true  // Запускаем анимацию при появлении
        }
    }
}
