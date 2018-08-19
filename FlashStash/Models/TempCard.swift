//
//  TempCard.swift
//  FlashStash
//
//  Created by Adam on 08/08/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import Foundation


enum CardSide {
    case front
    case back
}

enum CardContentPosistion {
    case top
    case bottom
}

enum inputType {
    case image
    case text
}


class TempCard {
    //
    // MARK: Properties
    //
    var front: TempSide
    var back: TempSide
    //
    // MARK: Init
    //
    init() {
        front = TempSide()
        back = TempSide()
    }
    
    convenience init(card: Card) {
        self.init()
        if card.questionImage != nil || card.questionText != nil {
            self.front.top = TempCardContentPosistion()
        }
        if card.answerImage != nil || card.answerText != nil {
            self.back.top = TempCardContentPosistion()
        }
        if let questionImage = card.questionImage {
            self.front.top?.image = UIImage(data: questionImage)
        }
        if let answerImage = card.answerImage {
            self.back.top?.image = UIImage(data: answerImage)
        }
        self.front.top?.text = card.questionText
        self.back.top?.text = card.answerText
    }
    //
    // MARK: Getters
    //
    var isComplete: Bool {
        return !front.isBlank && !back.isBlank
    }
    
    func getSide(_ side: CardSide) -> TempSide {
        if side == .front {
            return self.front
        }
        return self.back
    }
    //
    // MARK: Setters
    //
    func addMedia(side: CardSide, position: CardContentPosistion, media: Any) {
        getSide(side).addMedia(toPosition: position, media: media)
    }
}

class TempSide {
    //
    // MARK: Properties
    //
    var top: TempCardContentPosistion?
    var bottom: TempCardContentPosistion?
    //
    // MARK: Getters
    //
    var isBlank: Bool {
        return top?.isBlank ?? true && bottom?.isBlank ?? true
    }
    
    var hasImage: Bool {
        return top?.isImage ?? false || bottom?.isImage ?? false
    }
    
    var hasText: Bool {
        return top?.isText ?? false || bottom?.isText ?? false
    }
    
    var hasTwoSections: Bool {
        return top != nil && bottom != nil
    }
    
    func getPosition(_ position: CardContentPosistion) -> TempCardContentPosistion {
        if position == .top {
            if let _ = self.top {
                return self.top!
            } else {
                top = TempCardContentPosistion()
                return self.top!
            }
        } else {
            if let _ = self.bottom {
                return self.bottom!
            } else {
                bottom = TempCardContentPosistion()
                return self.bottom!
            }
        }
    }
    //
    // MARK: Setters
    //
    func addMedia(toPosition position: CardContentPosistion, media: Any) {
        getPosition(position).addMedia(media)
    }
    func deleteMedia(position: CardContentPosistion) {
        getPosition(position).deleteMedia()
    }
    func deleteContent(position: CardContentPosistion) {
        if position == .top {
            self.top = nil
        } else {
            self.bottom = nil
        }
    }
}

class TempCardContentPosistion {
    //
    // MARK: Properties
    //
    var image: UIImage?
    var text: String?
    var imageData: Data? {
            guard let image = image else { return nil }
            return UIImageJPEGRepresentation(image, 0.5)
    }
    //
    // MARK: Getters
    //
    var isBlank: Bool {
        return image == nil && text == nil
    }
    var isImage: Bool {
        return image != nil
    }
    var isText: Bool {
        return text != nil
    }
    
    func getMedia() -> Any? {
        if let image = image {
            return image
        }
        if let text = text {
            return text
        }
        return nil
    }
    //
    // MARK: Setters
    //
    func addMedia(_ media: Any){
        if let image = media as? UIImage {
            self.image = image
        }
        if let text = media as? String {
            self.text = text
        }
    }
    func deleteMedia() {
        self.image = nil
        self.text = nil
    }
}
