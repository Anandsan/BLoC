//
//  BloCTestCustomObserver.swift
//  
//
//  Created by Sankaran, Anand on 12/5/22.
//

import XCTest
import Combine
@testable import BLoC


class BloCTestCustomObserver: XCTestCase {
    enum Event {
        case increment
        case decrement
        case reset
    }

    class LogObserver : BLoCObserver {
        var error: BLoCError?
        var event: Event?
        var currentState: Int?
        func onCreate<Event, State>(bloc: BLoC<Event, State>) where Event : Equatable, State : Equatable {
            error = nil
            self.currentState = bloc.state as? Int
            
        }
        
        func onEvent<Event, State>(bloc: BLoC<Event, State>, event: Event) where Event : Equatable, State : Equatable {
            self.event = event as? BloCTestCustomObserver.Event
            self.currentState = bloc.state as? Int
            error = nil
        }
        
        func onTransition<Event, State>(bloc: BLoC<Event, State>, transition: Transition<Event, State>) where Event : Equatable, State : Equatable {
            error = nil
            self.currentState = transition.nextState as? Int
        }
        
        func onError<Event, State>(bloc: BLoC<Event, State>, error: Error) where Event : Equatable, State : Equatable {
            self.error = error as? BLoCError
            self.currentState = bloc.state as? Int
        }
        
        func onClose<Event, State>(bloc: BLoC<Event, State>) where Event : Equatable, State : Equatable {
            error = nil
        }
        
        
    }
    
    var log: LogObserver!
    var bloc:BLoC<Event, Int>!
    override func setUpWithError() throws {
        
        log = LogObserver()
        bloc = BLoC(initialState: 1, observer: log) { (state: Int, event: Event) in
            switch event {
            case .increment: return state + 1
            case .decrement: return state - 1
            case .reset: return 0
            }
        }
    }

    func testBLoCInit() throws {
        // Test the inital value
        XCTAssertNil(log.event, "Inital Bloc event is not null")
        XCTAssertEqual(log.currentState, 1)
    }
    
    func testBLoCEventIncrement() throws {
        let initalState = bloc.state
        // Test the state value of after one time increment
        bloc.add(event: .increment)
        XCTAssertEqual(log.event, .increment)
        XCTAssertEqual(log.currentState, initalState + 1)
    }
    
    func testBLoCEventDecrement() throws {
        
        let initalState = bloc.state
        // Test the state value of after one time decrement
        bloc.add(event: .decrement)
        XCTAssertEqual(log.event, .decrement)
        XCTAssertEqual(log.currentState, initalState - 1)
    }
    
    func testBLoCEventReset() throws {
        // Test the state value of after reset
        bloc.add(event: .reset)
        XCTAssertEqual(log.event, .reset)
        XCTAssertEqual(log.currentState, 0)
        
    }
    
    func testBLoNoStateChangeError() throws {
        // Test the state value of after reset
        bloc.add(event: .reset)
        bloc.add(event: .reset)

        XCTAssertEqual(log.error, BLoCError.stateNotChanged)
        XCTAssertEqual(log.currentState, 0)
        
    }
}
