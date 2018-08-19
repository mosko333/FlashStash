//
//  TempCardController.swift
//  FlashStash
//
//  Created by Adam on 08/08/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import Foundation

class TempCardController {
    var side: CardSide
    var tempCard = TempCard()
 
    init(side: CardSide) {
        self.side = side
    }
    
    func isCardComplete() -> Bool {
        return tempCard.isComplete
    }
    
    func sideHasImage() -> Bool {
        return tempCard.getSide(side).hasImage
    }
    
    func sideHasText() -> Bool {
        return tempCard.getSide(side).hasText
    }
    
    func isSideBlank() -> Bool {
        return tempCard.getSide(side).isBlank
    }
    
    func hasTwoSections() -> Bool {
        return tempCard.getSide(side).hasTwoSections
    }
    
    func isContentPositionBlank(position: CardContentPosistion) -> Bool {
        return tempCard.getSide(side).getPosition(position).isBlank
    }
    
    func contentPositionIsImage(position: CardContentPosistion) -> Bool {
        return tempCard.getSide(side).getPosition(position).isImage
    }
    
    func contentPositionIsText(position: CardContentPosistion) -> Bool {
        return tempCard.getSide(side).getPosition(position).isText
    }
    
    func addMedia(position: CardContentPosistion, media: Any){
        tempCard.addMedia(side: side, position: position, media: media)
    }
    
    func deleteContentPosition(position: CardContentPosistion) {
        tempCard.getSide(side).deleteContent(position: position)
    }
    
    func deleteMedia(position: CardContentPosistion) {
        tempCard.getSide(side).deleteMedia(position: position)
    }
    
    func saveCardIntoCoreData(deck: Deck) {
        let _ = CardController.createCardWithTempCard(tempCard: tempCard, to: deck)
    }
}
