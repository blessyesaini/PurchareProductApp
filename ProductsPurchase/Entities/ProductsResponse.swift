//
//  ProductsModel.swift
//  ProductsPurchase
//
//  Created by Blessy Elizabeth Saini on 24/03/2022.
//

import Foundation

// MARK: - ProductsResponse
struct ProductsResponse: Codable {
    let title, currency: String?
    let items: [ProductsData]?
}

// MARK: - Item
struct ProductsData: Codable {
    let id, sku: String?
    let image: String?
    let brand, name: String?
    let price: Int?
    let originalPrice: Int?
    let badges: [String]?
}
