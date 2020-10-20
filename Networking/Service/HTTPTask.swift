//
//  HTTPTask.swift
//  Networking
//
//  Created by Bruno Garelli on 10/19/20.
//

public typealias HTTPHeaders = [String: String]
/// Three basic kind of http tasks, there could be others, such as, download, upload..
public enum HTTPTask {
    case request
    case requestParameters(bodyParameters: Parameters?, urlParameters: Parameters?)
    case requestParametersAndHeaders(bodyParameters: Parameters?, urlParameters: Parameters?, additionalHeaders: HTTPHeaders?)
}
