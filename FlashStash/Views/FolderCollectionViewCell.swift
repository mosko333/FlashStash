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
    
    lazy var geture = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
    weak var delegate: FolderCellEditDelegate?
    
    @IBOutlet weak var folderNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        geture.delegate = self
        superview?.addGestureRecognizer(geture)
    }
    
    @objc func longPress() {
        delegate?.selectedFolder(cell: self)
    }
}

