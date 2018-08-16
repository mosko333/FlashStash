//
//  Notification.swift
//  FlashStash
//
//  Created by Adam on 02/08/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let topImageBtnTapped = Notification.Name("topImageBtnTapped")
    static let topTextBtnTapped = Notification.Name("topTextBtnTapped")
    static let deleteTopSectionBtnTapped = Notification.Name("deleteTopSectionBtnTapped")
    static let addFieldBtnTapped = Notification.Name("addFieldBtnTapped")
    static let bottomImageBtnTapped = Notification.Name("bottomImageBtnTapped")
    static let bottomTextBtnTapped = Notification.Name("bottomTextBtnTapped")
    static let cardTopSectionFilled = Notification.Name("cardTopSectionFilled")
    static let cardBottomSectionFilled = Notification.Name("cardBottomSectionFilled")
    static let deleteBottomSectionBtnTapped = Notification.Name("deleteBottomSectionBtnTapped")
    static let cardFlipped = Notification.Name("cardFlipped")
}
