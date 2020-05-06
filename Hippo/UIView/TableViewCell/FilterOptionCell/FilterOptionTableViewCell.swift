//
//  FilterOptionTableViewCell.swift
//  Fugu
//
//  Created by Vishal on 31/05/18.
//  Copyright © 2018 Socomo Technologies Private Limited. All rights reserved.
//

import UIKit

class FilterOptionTableViewCell: CoreTabelViewCell {

    @IBOutlet weak var verticleLineView: UIView!
    @IBOutlet weak var cellBackgroundView: UIView!
    @IBOutlet weak var cellLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCellView()
        resetCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        updateCellView(for: selected)
    }
    
    private func setupCellView() {
        verticleLineView.backgroundColor = UIColor.themeColor
        verticleLineView.isHidden = true
    }
    
    private func resetCell() {
        cellLabel.text = ""
    }
    
    private func updateCellView(for selected: Bool) {
        let theme = HippoTheme.theme
        DispatchQueue.main.async {
            self.cellBackgroundView.backgroundColor = selected ? theme.systemBackgroundColor.secondary : theme.systemBackgroundColor.tertiary
            self.verticleLineView.isHidden = !selected
        }
    }
    func setupCell(titleLabel: String) {
        resetCell()
        
        cellLabel.text = titleLabel
    }
    
}
