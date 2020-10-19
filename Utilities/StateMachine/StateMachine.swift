//
//  StateMachine.swift
//  Utilities
//
//  Created by Bruno Garelli on 10/16/20.
//

public final class StateMachine<State: Hashable> {
    public var currentState: State
    var transitions = [Transition<State>]()
    
    public init(initialState: State) {
        self.currentState = initialState
    }
    
    public func set(currentState: State) {
        self.currentState = currentState
    }
    
    public func add(transition: Transition<State>) {
        transitions.append(transition)
    }
    
    public func transition(to: State, execution: ExecutionBlock? = nil) {
        if let performable = transitions.filter({ $0.source == currentState && $0.destination == to }).first {
            performable.preBlock?()
            currentState = to
            execution?()
            performable.postBlock?()
        }
    }
}
