//
//  Card.swift
//  wallet
//
//  Created by Pietro Basso on 15/02/2019.
//  Copyright © 2019 Pietro Basso. All rights reserved.
//

import UIKit

struct Card: Hashable {
    let issuer: String
    let pointsCount: Int
    let offersCount: Int
}

extension Card {
    /**
     Descriptor is a dedicated type that can better describe a model to the UI, through an extension of the existing model.
     - Author: 152percent - [View Descriptors](https://152percent.com/blog/2018/4/16/view-descriptors)
     */
    struct Descriptor {
        
        private let card: Card
        
        init(card: Card) {
            self.card = card
        }
    }
    
    var descriptor: Descriptor {
        return Descriptor(card: self)
    }
}

extension Card.Descriptor {
    var title: String {
        return card.issuer
    }
    var description: String {
        return [String(card.pointsCount), "points"].joined(separator: " ")
    }
    var badgeCount: Int {
        return card.offersCount
    }
    var color: UIColor.Wallet {
        return UIColor.Wallet.brightColors.randomElement() ?? .red
    }
    var welcomeText: String {
        return ["You currently have", description, "🏅", offerText, "\nHappy shopping! 🛍✨"].compactMap { $0 }.joined(separator: " ")
    }
    var offerText: String? {
        guard card.offersCount > 0 else { return nil }
        switch card.offersCount {
        case 0:
            return nil
        case 1:
            return "\nThere's also one offer waiting for you 👀"
        default:
            return "\nThere are \(card.offersCount) offers waiting for you 👀"
        }
    }
}

extension Card {
    static var random: Card {
        let issuer = ["Pam", "Spar", "IKEA", "MediaMarkt", "Accessorize", "Zara", "H&M", "Hofer", "Lidl", "R&V", "Starbucks", "Eataly"].randomElement() ?? "Zara"
        let pointsCount = Int.random(in: 0...200)
        let offersCount = Int.random(in: 0...1)
        return Card(issuer: issuer, pointsCount: pointsCount, offersCount: offersCount)
    }
}
