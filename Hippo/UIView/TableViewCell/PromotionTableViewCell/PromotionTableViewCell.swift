//
//  PromotionTableViewCell.swift
//  HippoChat
//
//  Created by Clicklabs on 12/24/19.
//  Copyright © 2019 CL-macmini-88. All rights reserved.
//

import UIKit

class PromotionTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var promotionTitle: UILabel!
    @IBOutlet weak var promotionImage: UIImageView!
    
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var titleTopConstraint: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUpUI()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpUI()
    {
        //bgView.layer.borderWidth = HippoConfig.shared.theme.chatBoxBorderWidth
       // bgView.layer.borderColor = HippoConfig.shared.theme.chatBoxBorderColor.cgColor
       // bgView.layer.cornerRadius = 10
        bgView.layer.masksToBounds = true
        bgView.backgroundColor = UIColor.white
        
        promotionTitle.font = HippoConfig.shared.theme.titleFont
        promotionTitle.textColor = HippoConfig.shared.theme.titleTextColor
        
        descriptionLabel.font = HippoConfig.shared.theme.descriptionFont
        descriptionLabel.textColor = HippoConfig.shared.theme.descriptionTextColor
        
        dateTimeLabel.font = HippoConfig.shared.theme.dateTimeFontSize
        dateTimeLabel.textColor = HippoConfig.shared.theme.incomingMsgDateTextColor
    }
    
    func set(data: PromotionCellDataModel)
    {
        if data.imageUrlString.isEmpty
        {
            self.promotionImage?.isHidden = true
            self.imageHeightConstraint.constant = 0
        }
        else
        {
            self.imageHeightConstraint.constant = 160
            self.promotionImage?.isHidden = false
            let url = URL(string: data.imageUrlString)
            self.promotionImage.kf.setImage(with: url, placeholder: HippoConfig.shared.theme.placeHolderImage,  completionHandler:nil)
        }
        self.promotionTitle.text = data.title//"This is a new tittle"
       
       // self.promotionTitle.backgroundColor = UIColor.yellow
        self.descriptionLabel.text = data.description//"This is description of promotion in a new format"
        // print("text >>> \(self.descriptionLabel.text) height >> \(data.cellHeight)")
        
       // self.descriptionLabel.backgroundColor = UIColor.blue
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ss.SSS'Z'"
        let date = dateFormatter.date(from: data.createdAt)
        
       // print("date>> \(date)")
        let timeOfMessage = changeDateToParticularFormat(date ?? Date(), dateFormat: "dd MMM,yy h:mm a", showInFormat: true)
        
        self.dateTimeLabel.text = timeOfMessage
        
        self.layoutIfNeeded()
    }
}
