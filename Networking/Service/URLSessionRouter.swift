//
//  URLSessionRouter.swift
//  Networking
//
//  Created by Bruno Garelli on 10/19/20.
//

import Model

public final class URLSessionRouter/*<EndpointType: Endpoint>*/: NetworkRouter {

    private let networkStatus = NetworkStatus()
    private var networkReachable = true
    
    public init() {
        NotificationCenter.default.addObserver(self, selector: #selector(networkAvailable), name: .networkRestored, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(networkUnavailable), name: .networkLost, object: nil)
    }
    
    private var task: URLSessionTask?
    
    @objc private func networkAvailable() {
        networkReachable = true
    }
    
    @objc private func networkUnavailable() {
        networkReachable = false
    }
    
    public func request(_ route: Endpoint, completion: @escaping NetworkRouterCompletion) {
        guard networkReachable else {
            return completion( nil, nil, NetworkError.networkOffline )
        }
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
        cancel()
        request(route) {[weak self] data, response, error in
            guard let self = self else { return completion([], nil, nil) }
            let result = self.verify(data, response, error)
            switch result {
            case .failure(let error):
                switch error {
                case .SSLError:
                    return completion([], nil, nil)
                default:
                    return completion(nil, nil, error)
                }
            case .success(let data?):
                if let JSONObject = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
                    if let results = JSONObject["results"] as? [[String: Any]], let paging = JSONObject["paging"] as? [String: Any] {
                        let pagination = ProductPagination.parsedFrom(parameters: paging)
                        completion(results.compactMap({ route.fetchingModel?.parsedFrom(parameters: $0) }), pagination, error)
                    } else {
                        
                    }
                }
            case .success(_):
                return completion([], nil, NetworkError.badRequest)
            }
        }
    }
    
    private func verify(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Result<Data?, NetworkError> {
        if let urlError = error as? URLError, urlError.errorCode == -999 { /// Strange SSL error
            return .failure(NetworkError.SSLError)
        } else if let connectionError = error as? NetworkError, connectionError == .networkOffline {
            return .failure(.networkOffline)
        }
        if let httpResponse = response as? HTTPURLResponse {
            switch httpResponse.statusCode {
            case 200...299:
                return .success(data)
            case 400...499:
                return .failure(.badRequest)
            case 500...599:
                return .failure(.serverError)
            default:
                return .failure(.failed)
            }
        }
        return .failure(.failed)
    }
    
    public func cancel() {
        task?.cancel()
    }
    
    fileprivate func buildRequest(from route: Endpoint) throws -> URLRequest {
        guard networkReachable else { throw NetworkError.networkOffline }
        
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

