//
//  URLSessionRouter.swift
//  Networking
//
//  Created by Bruno Garelli on 10/19/20.
//

import Model

public final class URLSessionRouter/*<EndpointType: Endpoint>*/: NetworkRouter {

    public init() {}
    
    private var task: URLSessionTask?
    
    public func request(_ route: Endpoint, completion: @escaping NetworkRouterCompletion) {
        let session = URLSession.shared
        do {
            let request = try buildRequest(from: route)
            task = session.dataTask(with: request, completionHandler: { data, response, error in
                completion(data, response, error)
            })
        } catch {
            completion(nil, nil, error)
        }
        task?.resume()
    }
    
    public func fetch(_ route: Endpoint, completion: @escaping NetworkRouterModelCompletion) {
        request(route) { data, response, error in
            if data == nil { return completion([], nil, error) }
            if let JSONObject = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any] {
                if let results = JSONObject["results"] as? [[String: Any]], let paging = JSONObject["paging"] as? [String: Any] {
                    let pagination = ProductPagination.parsedFrom(parameters: paging)
                    completion(results.compactMap({ route.fetchingModel?.parsedFrom(parameters: $0) }), pagination, error)
                } else {
                    
                }
            }
        }
    }
    
    public func cancel() {
        task?.cancel()
    }
    
    fileprivate func buildRequest(from route: Endpoint) throws -> URLRequest {
        var request = URLRequest(url: route.url!.appendingPathComponent(route.path), cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
        
        request.httpMethod = route.method.rawValue
        do {
            switch route.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            case .requestParameters(let bodyParameters, let urlParameters):
                try configureParameters(bodyParameters: bodyParameters, urlParameters: urlParameters, request: &request)
            case .requestParametersAndHeaders(let bodyParameters, let urlParameters, let additionalHeaders):
                addAdditionalHeaders(additionalHeaders, request: &request)
                try configureParameters(bodyParameters: bodyParameters, urlParameters: urlParameters, request: &request)
            }
            return request
        } catch {
            throw error
        }
    }
    
    fileprivate func configureParameters(bodyParameters: Parameters?, urlParameters: Parameters?, request: inout URLRequest) throws {
        do {
            if let bodyParameters = bodyParameters {
                try JSONParameterEncoder.encode(urlRequest: &request, with: bodyParameters)
            }
            if let urlParameters = urlParameters {
                try URLParameterEncoder.encode(urlRequest: &request, with: urlParameters)
            }
        } catch {
            throw error
        }
    }
    
    fileprivate func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}

