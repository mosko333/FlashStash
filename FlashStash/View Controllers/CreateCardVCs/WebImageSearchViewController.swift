//
//  WebImageSearchViewController.swift
//  FlashStash
//
//  Created by Adam on 02/09/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import UIKit

class WebImageSearchViewController: UIViewController {
    //
    // MARK: - Properties
    //
    var imageSearchResults: [ImageSearchResult] = []
    //
    // MARK: - Outlets
    //
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var imageSearchResultsCollectionView: UICollectionView!
    //
    // MARK: - Lifecycle Functions
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupCollectionView()
        addObservers()
    }
    //
    // MARK: - Methods
    //
    func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(onlineImageSelected), name: .onlineImageSelected, object: nil)
    }
    @objc func onlineImageSelected() {
        navigationController?.popViewController(animated: true)
    }
}

//
// MARK: - Extensions
//
extension WebImageSearchViewController: UISearchBarDelegate {
    func setupSearchBar() {
        searchBar.delegate = self
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        guard let searchTerm = searchBar.text else { return }

        OnlineImageController.fetchImageSearchResultWith(searchTerm: searchTerm) { (imageSearchResults) in
            guard let fetchedAlbums = imageSearchResults else { return }
            self.imageSearchResults = fetchedAlbums
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                self.imageSearchResultsCollectionView.reloadData()
                self.imageSearchResultsCollectionView.scrollToItem(at: [0,0], at: .top, animated: true)
            }
        }
    }
}

extension WebImageSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func setupCollectionView() {
        imageSearchResultsCollectionView.delegate = self
        imageSearchResultsCollectionView.dataSource = self
        imageSearchResultsCollectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageSearchResults.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = imageSearchResultsCollectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! WebImageSearchCollectionViewCell
        let imageResult = imageSearchResults[indexPath.row]
        cell.imageSearchResult = imageResult
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 3 * 24) / 2
        return CGSize(width: width, height: width * 1.38)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12, left: 24, bottom: 12, right: 24)
    }

//    func findCardForCell(cell: CardListCollectionViewCell) -> Card {
//        guard let indexPath = self.cardListCollectionView.indexPath(for: cell),
//            let cards = deck?.cards,
//            let card = cards[indexPath.row] as? Card
//            else { return Card()}
//        return card
//    }
}
