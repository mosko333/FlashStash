//
//  WebImageSearchCollectionViewCell.swift
//  FlashStash
//
//  Created by Adam on 02/09/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import UIKit

class WebImageSearchCollectionViewCell: UICollectionViewCell, UIGestureRecognizerDelegate {
    //
    // MARK: - Properties
    //
    lazy var geture = UITapGestureRecognizer(target: self, action: #selector(tapped))
    var imageSearchResult: ImageSearchResult?{
        didSet {
            updateViews()
        }
    }
    lazy var fullSizeImageUrlString = imageSearchResult?.url
    //
    // MARK: - Outlets
    //
    @IBOutlet weak var resultsImageView: UIImageView!
    //
    // MARK: - Lifecycle Functions
    //
    override func awakeFromNib() {
        super.awakeFromNib()
        geture.delegate = self
        addGestureRecognizer(geture)
    }
    //
    // MARK: - Methods
    //
    func updateViews() {
        guard let imageSearchResult = imageSearchResult else { return }
        let imageUrlString = imageSearchResult.thumbnail
        OnlineImageController.fetchImageWith(urlString: imageUrlString ) { (image) in
            let fetchedImage = image
            DispatchQueue.main.async {
                self.resultsImageView.image = fetchedImage
            }
        }
    }
    //
    // MARK: - Actions
    //
    @objc func tapped() {
        print("tap")
        NotificationCenter.default.post(name: .onlineImageSelected, object: fullSizeImageUrlString)
    }
}
