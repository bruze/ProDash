//
//  FlowStarter.swift
//  ProDash
//
//  Created by Bruno Garelli on 10/17/20.
//

/// This protocol is just a tag to identify the controllers at the head of the flow in order to remove
/// child coordinators from parent when needed
protocol FlowStarter: BaseViewController {
    /// Instead of using Type Erasure I used a little shortcut to simplify things for the sake of this demo
    var anyCoordinator: Any? { get }
}
