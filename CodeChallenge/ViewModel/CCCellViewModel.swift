//
//  CCCellViewModel.swift
//  CodeChallenge


import UIKit

class CCCellViewModel: UIView {
    
    // MARK: - Properties Initializer
    lazy var dataLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        lbl.textColor     = .black
        return lbl
    }()
    //Creates Image view
    lazy var imageView: UIImageView = {
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 200))
        imgView.contentMode     = .scaleAspectFit
        imgView.clipsToBounds   = true
        imgView.backgroundColor = .clear
        imgView.isHidden        = false
        imgView.image = UIImage(named: Constants.defaultImage.rawValue)
        return imgView
    }()
    
    var dataInfo : DataItem?
    
    let imageManger = ImageManager()
    
    func configureCell(dataInfo: DataItem) {
        self.dataInfo = dataInfo
        if(self.dataInfo?.type == Constants.image.rawValue) {
            self.imageManger.downloadImageForUrl(dataInfo: self.dataInfo!, completion: {(image) in
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            })
            self.dataLabel.isHidden = true
            self.imageView.isHidden = false
        } else {
            self.imageView.isHidden = true
            self.dataLabel.isHidden = false
            self.dataLabel.text = self.dataInfo?.data
        }
    }
    
    func resetUIViewData() {
        self.imageView.image = UIImage(named: Constants.defaultImage.rawValue)
        self.dataLabel.text = self.dataInfo?.data
    }
}
