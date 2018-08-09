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
    let tempCard: TempCard
 
    init(side: CardSide, tempCard: TempCard) {
        self.side = side
        self.tempCard = tempCard
    }
    
    func isCardComplete() -> Bool {
        return tempCard.isComplete
    }
    
    func sideHasImage(side: CardSide) -> Bool {
        return tempCard.getSide(side).hasImage
    }
    
    func sideHasText(side: CardSide) -> Bool {
        return tempCard.getSide(side).hasText
    }
    
    func isSideBlank(side: CardSide) -> Bool {
        return tempCard.getSide(side).isBlank
    }
    
    func isContentPositionBlank(side: CardSide, position: CardContentPosistion) -> Bool {
        return tempCard.getSide(side).getPosition(position).isBlank
    }
    
    func contentPositionIsImage(side: CardSide, position: CardContentPosistion) -> Bool {
        return tempCard.getSide(side).getPosition(position).isImage
    }
    
    func contentPositionIsText(side: CardSide, position: CardContentPosistion) -> Bool {
        return tempCard.getSide(side).getPosition(position).isText
    }
    
    func addMedia(side: CardSide, position: CardContentPosistion, media: Any){
        tempCard.addMedia(side: side, position: position, media: media)
    }
    
    func deleteContentPosition(side: CardSide, position: CardContentPosistion) {
        tempCard.getSide(side).deleteContent(position: position)
    }
    
    func deleteMedia(side: CardSide, position: CardContentPosistion) {
        tempCard.getSide(side).deleteMedia(position: position)
    }
}
