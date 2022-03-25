//
//  WhishListViewController.swift
//  ProductsPurchase
//
//  Created by Blessy Elizabeth Saini on 25/03/2022.
//

import UIKit

protocol ProductWhishListViewControllerDelegate {
    func didTapCloseButton()
}

class ProductWhishListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,WishListTableViewCellDelegate {

    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Properties
    var delegate: ProductWhishListViewControllerDelegate?
    var productResponseData: [ProductsData]?
    var viewModel = ProductWishListViewModel()
   var viewData = [WishListTableViewCellModel]()
    var currency: String?
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView()
    
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewData = self.viewModel.getViewData(currency: self.currency)
        self.titleLabel.text = "WISHLIST (\(self.viewData.count))"
        tableView.reloadData()
    }
    func prepareTableView() {
        tableView.register(UINib(nibName: "WishListTableViewCell", bundle: nil), forCellReuseIdentifier: WishListTableViewCell.reuseIdentifier)
        tableView.estimatedRowHeight = 200.0
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewData.count 
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WishListTableViewCell.reuseIdentifier, for: indexPath) as! WishListTableViewCell
        cell.data = viewData[indexPath.row]
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailViewController") as? ProductDetailViewController {
            let selectedItem = self.viewData[indexPath.row]
            
            vc.data = self.viewModel.getProductsListCollectionViewCellModel(data: selectedItem)
            self.present(vc, animated: true,completion: nil)
        }
    }

    @IBAction func closeTapped(_ sender: Any) {
        self.dismiss(animated: true) {
            self.delegate?.didTapCloseButton()
        }
    }
    
    func didTapRemove(tag: Int) {
    
            WhishList.shared.removeProductToWhishList(product: WhishList.shared.productsArray[tag])
            
            self.viewData = self.viewModel.getViewData(currency: self.currency)
            self.titleLabel.text = "WISHLIST (\(self.viewData.count))"
            tableView.reloadData()
        
     
    }
}
