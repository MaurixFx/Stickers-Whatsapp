//
//  StickerCell.swift
//  TestStickers
//
//  Created by Mauricio Figueroa olivares on 7/24/19.
//  Copyright © 2019 Mauricio Figueroa olivares. All rights reserved.
//

import UIKit

class StickerCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.clipsToBounds = true
        return img
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupCell() {
        addSubview(imageView)
        imageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 5, paddingRight: 5, paddingBottom: 5, width: 0, height: 0)
    }
    
    func displaySticker(sticker: Sticker) {
        let image = sticker.imageData.image(withSize: CGSize(width: 256, height: 256))
        self.imageView.image = image
    }
    
}
