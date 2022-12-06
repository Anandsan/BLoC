//
//  BLoC.swift
//  
//
//  Created by Sankaran, Anand on 12/1/22.
//

import Combine
import Foundation

final public class BLoC<Event, State>: ObservableObject where State: Equatable, Event: Equatable {

    @Published internal(set) public var state: State
    internal(set) public var event: Event?

    private let observer: BLoCObserver
    private let map: (State, Event) -> State
    
    var description: String {
        "BLoC event: \(String(describing: event)) and state: \(state)"
    }
    
    public convenience init(initialState: State, map: @escaping (State, Event) -> State) {
        self.init(initialState: initialState, observer: BLoCObserverLog(), map: map )
    }
    
    public init(initialState: State, observer: BLoCObserver, map: @escaping (State, Event) -> State) {
        self.state = initialState
        self.observer = observer
        self.map = map
        observer.onCreate(bloc: self)
    }
    
    deinit {
        observer.onClose(bloc: self)
    }
    
    /**
     Adds a new event.
     - parameter event: new event.
     */
    public func add(event: Event) {
        observer.onEvent(bloc: self, event: event)
        self.event = event
        state = mapState(to: event)
    }


    private func mapState(to event: Event) -> State {
            let nextState: State = map(state, event)
            let transition: Transition = Transition(
                currentState: self.state,
                event: event,
                nextState: nextState
            )
            if transition.nextState == self.state {
                self.observer.onError(bloc: self, error: BLoCError.stateNotChanged)
                return self.state
            }
            self.observer.onTransition(bloc: self, transition: transition)
            return transition.nextState
    }
}

final public class Transition<Event, State> {
    public let currentState: State
    public let event: Event
    public let nextState: State

    var description: String {
        "Event: \(event) transition from currentState: \(currentState) to nextState: \(nextState)"
    }

    init(
        currentState: State,
        event: Event,
        nextState: State
    ) {
        self.currentState = currentState
        self.event = event
        self.nextState = nextState
    }
}

/**
 Bloc errors
*/
public enum BLoCError: Error {
    case stateNotChanged
    case noEvent
}
