// For License please refer to LICENSE file in the root of Persei project

import Foundation
import UIKit
import SnapKit

class MenuCell: UICollectionViewCell {
    // MARK: - Init
    private func commonInit() {
        backgroundView = UIView()
        
        //let views: [NSObject: AnyObject] = ["imageView": imageView, "shadowView": shadowView,"titleLabel":titleLabel]
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(shadowView)
        self.contentView.addSubview(titleLabel)
        self.titleLabel.textColor = UIColor.whiteColor()
        self.titleLabel.textAlignment =  NSTextAlignment.Center
        
        imageView.contentMode = .ScaleAspectFit
        imageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        imageView.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.contentView.snp_centerX)
            make.top.equalTo(self.contentView.snp_top)
            make.width.height.equalTo(50)
            
        }
        shadowView.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.contentView.snp_centerX)
            make.bottom.equalTo(self.contentView.snp_bottom)
            make.width.equalTo(self.contentView.snp_width)
            make.height.equalTo(2)
        }
        titleLabel.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.contentView.snp_centerX)
            make.bottom.equalTo(self.contentView.snp_bottom).offset(-5)
            make.left.equalTo(self.contentView.snp_left)
            make.right.equalTo(self.contentView.snp_right)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // MARK: - Reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        
        object = nil
    }
    
    // MARK: - ShadowView
    private let shadowView = UIView()
    
    // MARK: - ImageView
    private let imageView = UIImageView()
    
    // MARK: - TitleLabel
    private let titleLabel = UILabel()
    
    // MARK: - Object
    var object: MenuItem? {
        didSet {
            imageView.image = object?.image
            imageView.highlightedImage = object?.highlightedImage
            shadowView.backgroundColor = object?.shadowColor
            titleLabel.text = object?.title
            updateSelectionVisibility()
        }
    }
    
    // MARK: - Selection
    private func updateSelectionVisibility() {
        imageView.highlighted = selected
        backgroundView?.backgroundColor = selected ? object?.highlightedBackgroundColor : object?.backgroundColor
    }
    
    override var selected: Bool {
        didSet {
            updateSelectionVisibility()
        }
    }
}