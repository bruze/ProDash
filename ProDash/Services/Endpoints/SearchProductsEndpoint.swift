//
//  SearchProductsEndpoint.swift
//  ProDash
//
//  Created by Bruno Garelli on 10/19/20.
//

import Networking
import Model

struct SearchProductsEndpoint: Endpoint {
    let fetchingModel: Model.Type? = Product.self
    let path = "/sites/MLA/search"
    let method: HTTPMethod = .get
    var task: HTTPTask {
        return .requestParameters(bodyParameters: nil, urlParameters: ["q": query, "offset": offset])
    }
    var headers: HTTPHeaders?
    var query = ""
    var offset = 0
}
