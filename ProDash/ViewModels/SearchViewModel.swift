//
//  SearchViewModel.swift
//  ProDash
//
//  Created by Bruno Garelli on 10/20/20.
//

import Combine
import Model

final class SearchViewModel {
    //MARK: Members
    private var services: ServiceLocator?
    private var productsEndpoint = SearchProductsEndpoint()
    private var pagination = ProductPagination()
    //MARK: Setup
    init(services: ServiceLocator?) {
        self.services = services
    }
    //MARK: Action
    private func fetch() {
        services?.networkRouter.fetch(productsEndpoint, completion: {[weak self] objects, paginationInfo, error in
            guard let self = self else { return }
            if let pages = paginationInfo { self.pagination = pages }
        })
    }
    
    func update(query: String) {
        productsEndpoint.query = query
        fetch()
    }
    
    func fetchMoreProducts() {
        productsEndpoint.offset += pagination.limit
        fetch()
    }
}
