//
//  ProductDetailViewController.swift
//  ProductsPurchase
//
//  Created by Blessy Elizabeth Saini on 24/03/2022.
//

import UIKit
import Kingfisher
class ProductDetailViewController: UIViewController {
    @IBOutlet weak var brandLabel: UILabel!
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var originalAmountLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var buttonAddToBag: UIButton!
    
    var data: ProductsListCollectionViewCellModel?
    var productResponseData: ProductsData?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bottomView.layer.makeShadow(style: .smallUp)
        let url = URL(string: data?.productImage ?? "")
        self.productImageView.kf.setImage(with: url,placeholder: UIImage(named: "product"))
        self.brandLabel.text = data?.brand
        self.productNameLabel.text = data?.name
        self.amountLabel.text = data?.amount
        self.originalAmountLabel.isHidden = (data?.originalAmount == nil) ? true: false
        self.originalAmountLabel.attributedText = data?.originalAmount?.strikeThrough()
        let isItemAdded = WhishList.shared.productsArray.contains { $0.id == data?.idValue}
        self.buttonAddToBag.backgroundColor = (isItemAdded == false) ?.black : .lightGray
        
        if self.buttonAddToBag.backgroundColor == .lightGray {
            self.buttonAddToBag.isEnabled = false
        }
        else {
            self.buttonAddToBag.isEnabled = true
        }
        // Do any additional setup after loading the view.
    }
    
 
    @IBAction func buttonTapped(_ sender: Any) {
        if let productResponseData = productResponseData {
            WhishList.shared.addProductToWhishList(product: productResponseData)
            self.buttonAddToBag.isEnabled = false
            self.buttonAddToBag.backgroundColor = .lightGray
        }
     
    }
    

  

}
