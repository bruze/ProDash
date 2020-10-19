//
//  Transition.swift
//  Utilities
//
//  Created by Bruno Garelli on 10/16/20.
//

public typealias ExecutionBlock = (() -> Void)

public struct Transition<State> {
    let source     : State
    let destination: State
    let preBlock   : ExecutionBlock?
    let postBlock  : ExecutionBlock?
    
    init(from: State, to: State, preBlock: ExecutionBlock? = nil, postBlock: ExecutionBlock? = nil) {
        self.source = from
        self.destination = to
        self.preBlock = preBlock
        self.postBlock = postBlock
    }
}
