//
//  CardListCollectionViewCell.swift
//  FlashStash
//
//  Created by Adam on 31/07/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import UIKit
protocol CardListCellEditDelegate: class {
    func selectedCard(cell: CardListCollectionViewCell)
}

class CardListCollectionViewCell: UICollectionViewCell, UIGestureRecognizerDelegate {
    //
    // MARK: - Properties
    //
    lazy var geture = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
    weak var delegate: CardListCellEditDelegate?
    //
    // MARK: - Outlets
    //
    @IBOutlet weak var questionTextLabel: UILabel!
    @IBOutlet weak var questionImage: UIImageView!
    //
    // MARK: - Lifecycle Functions
    //
    override func awakeFromNib() {
        super.awakeFromNib()
        geture.delegate = self
        addGestureRecognizer(geture)
    }
    //
    // MARK: - Actions
    //
    @objc func longPress() {
        print("Long press")
        delegate?.selectedCard(cell: self)
    }
}
