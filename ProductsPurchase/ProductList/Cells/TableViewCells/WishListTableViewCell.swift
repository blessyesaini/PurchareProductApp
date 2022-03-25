//
//  WishListTableViewCell.swift
//  ProductsPurchase
//
//  Created by Blessy Elizabeth Saini on 25/03/2022.
//

import UIKit
import Kingfisher

protocol WishListTableViewCellDelegate {
    func didTapRemove(tag: Int)
}
struct WishListTableViewCellModel {
    var idValue: String?
    var id: Int?
    var name: String?
    var productImageURL: String?
    var amount: String?
    var brand: String?
}
class WishListTableViewCell: UITableViewCell {
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    
    @IBOutlet weak var productImageView: UIImageView!
    
    static let reuseIdentifier = "WishListTableViewCell"
    
    var delegate: WishListTableViewCellDelegate?
    var data: WishListTableViewCellModel? {
        didSet {
            loadData()
        }
    }
    func loadData() {
        let url = URL(string: data?.productImageURL ?? "")
        self.productImageView.kf.setImage(with: url, placeholder: UIImage(named: "product"))
        self.brandLabel.text = data?.brand
        self.productNameLabel.text = data?.name
        self.amountLabel.text = data?.amount
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func removeTapped(_ sender: Any) {
        self.delegate?.didTapRemove(tag: data?.id ?? 0)
    }
}
