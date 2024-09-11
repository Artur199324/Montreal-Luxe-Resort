//
//  Comment.swift
//  Montreal Luxe Resort
//
//  Created by Artur on 11.09.2024.
//

import Foundation
struct Comment: Identifiable, Codable {
    let id: UUID
    let name: String
    let message: String
}
