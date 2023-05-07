//
//  ImageCell.swift
//  collectionView
//
//  Created by Nurmukhanbet Sertay on 06.05.2023.
//

import UIKit
import SnapKit

class ImageCell: UICollectionViewCell {
    
    func configure(image: UIImage?) {
        imageView.image = image
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("int=it svo")
    }
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
}

private extension ImageCell {
    
    func initialize() {
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.size.equalTo(140)
            make.edges.equalToSuperview().inset(5)
        }
    }
}
