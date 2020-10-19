//
//  User.swift
//  Model
//
//  Created by Bruno Garelli on 10/16/20.
//

import RealmSwift
import Utilities

public final class User: Object, Model {
    public enum UserState {
        case guest
        case logged
    }
    
    @objc public var alias: String = ""
    var state = StateMachine<UserState>(initialState: .guest)
    public var currentState: UserState { return state.currentState }
    //MARK: Setup
    public override class func primaryKey() -> String? {
        return "alias"
    }
    
    public func setState(transitions: [Transition<UserState>]) {
        transitions.forEach({ state.add(transition: $0) })
    }
    
    public func set(state: UserState) {
        self.state.set(currentState: state)
    }
}
