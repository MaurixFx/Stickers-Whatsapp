//
//  MainViewStickersController.swift
//  TestStickers
//
//  Created by Mauricio Figueroa olivares on 7/24/19.
//  Copyright © 2019 Mauricio Figueroa olivares. All rights reserved.
//

import UIKit

class MainViewStickersController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.delegate = self
        view.dataSource = self
        layout.scrollDirection = .horizontal
        view.register(StickerCell.self, forCellWithReuseIdentifier: "StickerCell")
        view.isScrollEnabled = false
        view.allowsSelection = true
        view.backgroundColor = .clear
        view.layer.borderWidth = 0
        return view
    }()
    
    private var myStickerPack: StickerPack!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        //fetchStickerPacks()
        
        do {
            let stickerPack = try StickerPack(identifier: "com.mfigueroa.TestStickers",
                                              name: "uestickers",
                                              publisher: "UnionEspanola",
                                              trayImageFileName: "defaultPackImage.png",
                                              publisherWebsite: "",
                                              privacyPolicyWebsite: nil,
                                              licenseAgreementWebsite: nil)
            
            try stickerPack.addSticker(contentsOfFile: "01_Cuppy_smile.png", emojis: nil)
            try stickerPack.addSticker(contentsOfFile: "02_Cuppy_lol.png", emojis: nil)
            try stickerPack.addSticker(contentsOfFile: "03_Cuppy_rofl.png", emojis: nil)
            try stickerPack.addSticker(contentsOfFile: "04_Cuppy_sad.png", emojis: nil)
            
            myStickerPack = stickerPack
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }

        } catch let error {
            print(error.localizedDescription)
        }
        
        
    }
    
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.fillSuperview()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_setting.png"), style: .done, target: self, action: #selector(handleSave))
    }
    
    @objc func handleSave() {
        myStickerPack?.sendToWhatsApp { _ in }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myStickerPack.stickers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width / 3, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let stickerCell = collectionView.dequeueReusableCell(withReuseIdentifier: "StickerCell", for: indexPath) as! StickerCell
        stickerCell.displaySticker(sticker: myStickerPack.stickers[indexPath.row])
        return stickerCell
    }
}
