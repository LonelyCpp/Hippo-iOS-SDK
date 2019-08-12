//
//  NavigationTitleView.swift
//  Hippo Agent
//
//  Created by Vishal on 22/05/19.
//  Copyright © 2019 Socomo Technologies Private Limited. All rights reserved.
//

import UIKit

@objc protocol NavigationTitleViewDelegate: class {
    func backButtonClicked()
    @objc optional func titleClicked()
    @objc optional func imageIconClicked()
}

class NavigationTitleView: UIView {

    @IBOutlet weak var backButtonWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var profileImageViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var labelContainer: UIStackView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    weak var delegate: NavigationTitleViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupDefaultUI()
        addGesture()
    }
    @IBAction func backButtonClicked(_ sender: Any) {
        delegate?.backButtonClicked()
    }
    
    class func loadView(_ frame: CGRect, delegate: NavigationTitleViewDelegate) -> NavigationTitleView {
        let array = FuguFlowManager.bundle?.loadNibNamed("NavigationTitleView", owner: self, options: nil)
        let view: NavigationTitleView? = array?.first as? NavigationTitleView
        view?.frame = frame
        guard let customView = view else {
            return NavigationTitleView()
        }
        customView.setupDefaultUI()
        customView.delegate = delegate
        return customView
    }
    
    func setupDefaultUI() {
        titleLabel.font = HippoConfig.shared.theme.headerTextFont
        titleLabel.textColor = HippoConfig.shared.theme.headerTextColor
        
        if HippoConfig.shared.theme.leftBarButtonImage != nil {
            backButton.setImage(HippoConfig.shared.theme.leftBarButtonImage, for: .normal)
        }
    
        backButton.tintColor = HippoConfig.shared.theme.headerTextColor
        
        hideProfileImage()
        
        hideDescription()
        descLabel.text = "tap to view info"
        titleLabel.text = ""
    }
    func setTitle(title: String) {
        titleLabel.text = "  " + title.trimWhiteSpacesAndNewLine()
    }
    
    func addGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(titleViewClicked))
        labelContainer.addGestureRecognizer(tapGesture)
        profileImageView.isUserInteractionEnabled = true
        let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(imageClicked))
        profileImageView.addGestureRecognizer(imageTapGesture)
    }
    @objc func titleViewClicked() {
        delegate?.titleClicked?()
    }
    @objc func imageClicked() {
        delegate?.imageIconClicked?()
    }
    
    func hideDescription() {
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
            self.descLabel.isHidden = true
            self.labelContainer.layoutIfNeeded()
        }, completion: nil)
    }
    
    func showDescription() {
        UIView.animate(withDuration: 0.2, delay: 0, options: .transitionFlipFromTop, animations: {
            self.descLabel.isHidden = false
            self.labelContainer.layoutIfNeeded()
        }, completion: nil)
    }
    
    func setData(imageUrl: String?, name: String?) {
        showProfileImage()
        setNameAsTitle(name)
        guard let url = URL(string: imageUrl ?? "") else {
            return
        }
        
        
        profileImageView.kf.setImage(with: url, placeholder: nil,  completionHandler: {(_, error, _, _) in
            guard let parsedError = error else {
                return
            }
            print(parsedError.localizedDescription)
        })
    }
    
    func setNameAsTitle(_ name: String?) {
        if let parsedName = name {
            self.profileImageView.setImage(string: parsedName, color: UIColor.lightGray, circular: true)
        } else {
          self.profileImageView.image = HippoConfig.shared.theme.placeHolderImage
        }
    }
    
    func hideProfileImage() {
        profileImageView.isHidden = true
        backButtonWidthConstraint.constant = 40
        layoutIfNeeded()
    }
    
    func showProfileImage() {
        profileImageView.isHidden = false
        profileImageView.cornerRadius = profileImageView.bounds.height / 2
        backButtonWidthConstraint.constant = 28
        layoutIfNeeded()
    }
    
}