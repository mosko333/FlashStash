//
//  Notification.swift
//  FlashStash
//
//  Created by Adam on 02/08/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import Foundation

extension Notification.Name {
    // Add Card
    // From ContainerView to CreateCardVC
    static let addFieldBtnTapped = Notification.Name("addFieldBtnTapped")
    static let deleteTopSectionBtnTapped = Notification.Name("deleteTopSectionBtnTapped")
    static let deleteBottomSectionBtnTapped = Notification.Name("deleteBottomSectionBtnTapped")
    static let cardTopSectionFilled = Notification.Name("cardTopSectionFilled")
    static let cardBottomSectionFilled = Notification.Name("cardBottomSectionFilled")
    static let cardFlipped = Notification.Name("cardFlipped")
    static let segueToOnlineImageSearch = Notification.Name("segueToOnlineImageSearch")
    static let onlineImageSelected = Notification.Name("onlineImageSelected")
    
    // From CreateCardVC or StudyCardVC to ContainerView
    static let sendCardMedia = Notification.Name("sendCardMedia")
    
}
