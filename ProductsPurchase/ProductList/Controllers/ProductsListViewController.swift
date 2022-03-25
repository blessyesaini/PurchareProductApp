//
//  ViewController.swift
//  ProductsPurchase
//
//  Created by Blessy Elizabeth Saini on 24/03/2022.
//

import UIKit

class ProductsListViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ProductsListCollectionViewCellDelegate, ProductWhishListViewControllerDelegate {
   
    // MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    var viewModel = ProductListViewModel()
    var viewData = [ProductsListCollectionViewCellModel]()

    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareCollectionView()
       
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.getViewData { result in
            switch result {
            case .success(let data):
                self.viewData = data
                self.collectionView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Custom Methods
    func prepareCollectionView() {
    
    collectionView.register(UINib(nibName: "ProductsListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ProductsListCollectionViewCell.reuseIdentifier)
    }
    // MARK: - UICollectionViewDataSource
   
   func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
       return viewData.count
   }
    
   func numberOfSections(in _: UICollectionView) -> Int {
       return 1
   }
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductsListCollectionViewCell.reuseIdentifier, for: indexPath) as! ProductsListCollectionViewCell
       cell.data = self.viewData[indexPath.row]
       cell.isItemSelectedInCell = WhishList.shared.productsArray.contains(where: { $0.id   == self.viewData[indexPath.row].idValue
       })
   
       cell.delegate = self
       return cell
   }
   // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let space = CGFloat(3*16)
        let numberOfColumn = 2.0
        let width = ((self.view.frame.size.width) - (space))/CGFloat(numberOfColumn)
        return CGSize(width: width, height: 350)
       }
   
    @IBAction func barButtonTapped(_ sender: Any) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProductWhishListViewController") as? ProductWhishListViewController {
            vc.delegate = self
            vc.currency = self.viewModel.currency ?? ""
            vc.productResponseData = self.viewModel.productResponseData
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    //MARK: - Delegate
  
    func didTapAddToWhishlist(_ tag: Int, isItemSelected: Bool) {
        if let selectedProductData = self.viewModel.productResponseData {
            if isItemSelected == true {
                WhishList.shared.addProductToWhishList(product: selectedProductData[tag])
            }
            else {
                WhishList.shared.removeProductToWhishList(product: selectedProductData[tag])
                
            }
       
    }
    }
    func didTapProduct(_ tag: Int) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailViewController") as? ProductDetailViewController {
            let selectedItem = self.viewData[tag]
            vc.data = selectedItem
            vc.productResponseData = self.viewModel.productResponseData?[tag]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    func didTapCloseButton() {
        self.viewWillAppear(true)
    }
}
