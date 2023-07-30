//
//  CollectionViewCell.swift
//  Currencies_mvc
//
//  Created by Gökhan Gökoğlan on 3.07.2023.
//

import UIKit

class CurrencyCell: UICollectionViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var changeLabel: UILabel!
    @IBOutlet weak var nameExtLabel: UILabel!
    
    func configure(with currency: Currency) {
            nameLabel.text = currency.name
            priceLabel.text = "₺ \(currency.price)"       
            imageView.image = currency.image
            changeLabel.text = "%\(currency.change)"
            nameExtLabel.text = currency.nameExt
               
        if String(currency.change).hasPrefix("-") {
            changeLabel.textColor = UIColor(red: 0.91, green: 0.314, blue: 0.227, alpha: 1)
        } else {
            changeLabel.textColor = UIColor(red: 0.039, green: 0.698, blue: 0.49, alpha: 1)
        }
    }
}
