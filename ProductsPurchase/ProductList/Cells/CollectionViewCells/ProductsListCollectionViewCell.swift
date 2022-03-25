//
//  ProductsListCollectionViewCell.swift
//  ProductsPurchase
//
//  Created by Blessy Elizabeth Saini on 24/03/2022.
//

import UIKit
import Kingfisher

enum BadgeType : String {
    case sale = "SALE"
    case new = "NEW"
}
protocol ProductsListCollectionViewCellDelegate {
    func didTapAddToWhishlist(_ tag: Int, isItemSelected: Bool)
    func didTapProduct(_ tag: Int)
}
struct ProductsListCollectionViewCellModel {
    var idValue: String?
    var id: Int?
    var name: String?
    var productImage: String?
    var badges: [String]?
    var amount: String?
    var brand: String?
    var originalAmount: String?
}


class ProductsListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bookmarkImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var originalPriceLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var badgeSale: EdgeInsetLabel!
    @IBOutlet weak var badgeNew: EdgeInsetLabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    
    var isItemSelected = false
    var data: ProductsListCollectionViewCellModel? {
        didSet {
            loadData()
        }
    }
    var isItemSelectedInCell: Bool? {
        didSet {
            bookmarkImageView.image =   ( isItemSelectedInCell  == true) ? UIImage(named: "bookmarkFilled"): UIImage(named: "bookmark")
        }
    }
    var delegate: ProductsListCollectionViewCellDelegate?
    static let reuseIdentifier  = "ProductsListCollectionViewCell"
    func loadData() {
       
      
        self.brandLabel.text = data?.name
        self.productNameLabel.text = data?.brand
        self.amountLabel.text = data?.amount
        let url = URL(string: data?.productImage ?? "")
        self.productImageView.kf.setImage(with: url,placeholder: UIImage(named: "product"))
        self.bgView.layer.makeShadow(style: .smallUp)
       
        if let originalAmount = data?.originalAmount {
            self.originalPriceLabel.attributedText = originalAmount.strikeThrough()
            self.originalPriceLabel.isHidden =  false
        }
        else {
            self.originalPriceLabel.isHidden =  true
        }
        if let badges = data?.badges {
            for badge in badges {
                if badge == BadgeType.sale.rawValue {
                    self.badgeSale.text = badge
                    self.badgeSale.isHidden = false
                }
                if badge == BadgeType.new.rawValue {
                    self.badgeNew.text = badge
                    self.badgeNew.isHidden = false
                }
            }
        }
  
    }
    
    @IBAction func bookmarkTapped(_ sender: Any) {
        isItemSelected = (isItemSelected == false) ?true:false
        WhishList.shared.isItemSelected = isItemSelected
        bookmarkImageView.image =   (isItemSelected == true) ? UIImage(named: "bookmarkFilled"): UIImage(named: "bookmark")
       
        self.delegate?.didTapAddToWhishlist(data?.id ?? 0, isItemSelected: isItemSelected)
    }
  
    override func awakeFromNib() {
        super.awakeFromNib()
        self.badgeNew.isHidden = true
        self.badgeSale.isHidden = true
        // Initialization code
    }
    @IBAction func itemTapped(_ sender: Any) {
        self.delegate?.didTapProduct(data?.id ?? 0)
    }
}
