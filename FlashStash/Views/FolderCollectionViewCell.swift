//
//  FolderCollectionViewCell.swift
//  FlashStash
//
//  Created by Adam on 27/07/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import UIKit
protocol FolderCellEditDelegate: class {
    func selectedFolder(cell: FolderCollectionViewCell)
}

class FolderCollectionViewCell: UICollectionViewCell, UIGestureRecognizerDelegate {
    //
    // MARK: - Properties
    //
    lazy var geture = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
    weak var delegate: FolderCellEditDelegate?
    //
    // MARK: - Outlets
    //
    @IBOutlet weak var folderNameLabel: UILabel!
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
        delegate?.selectedFolder(cell: self)
    }
}

