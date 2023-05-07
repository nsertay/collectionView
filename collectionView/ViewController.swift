//
//  ViewController.swift
//  collectionView
//
//  Created by Nurmukhanbet Sertay on 06.05.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        loadImages()
    }

    private var collectionView: UICollectionView!
    private var images: [UIImage?] = []
    private let apiManager = APIManager()
}

private extension ViewController {
    
    func loadImages() {
        let imagesIDs = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        
        imagesIDs.forEach { id in
            apiManager.loadImages(id: id) { [weak self] image in
                DispatchQueue.main.async {
                        self?.images.append(image)
                        self?.collectionView.reloadData()
                }
            }
        }
        
    }
    func initialize() {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().inset(50)
            make.height.equalTo(150)
        }
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCell
        cell.configure(image: images[indexPath.row])
        return cell
    }
    
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 150, height: 150)
    }
}
