//
//  BloCTest.swift
//  
//
//  Created by Sankaran, Anand on 12/2/22.
//

import XCTest
@testable import BLoC

class BloCTest: XCTestCase {
    enum Event {
        case increment
        case decrement
        case reset
    }
    
    func getBloc() -> BLoC<Event, Int> {
        let bloc = BLoC(initialState: 1) { (state: Int, event: Event) in
            switch event {
            case .increment: return state + 1
            case .decrement: return state - 1
            case .reset: return 0
            }
        }
        return bloc
    }

    func testBLoCInit() throws {
        let bloc = getBloc()
        // Test the inital value of state as 1
        XCTAssertEqual(bloc.state, 1)
    }
    
    func testBLoCEventIncrement() throws {
        let bloc = getBloc()
        let initalState = bloc.state
        // Test the state value of after one time increment
        bloc.add(event: .increment)
        XCTAssertEqual(bloc.state, initalState + 1)
        // Test the state value of after two time increment
        bloc.add(event: .increment)
        bloc.add(event: .increment)
        XCTAssertEqual(bloc.state, initalState + 3)
    }
    
    func testBLoCEventDecrement() throws {
        let bloc = getBloc()
        let initalState = bloc.state
        // Test the state value of after one time decrement
        bloc.add(event: .decrement)
        XCTAssertEqual(bloc.state, initalState - 1)
        
        // Test the state value of after three time decrement
        bloc.add(event: .decrement)
        bloc.add(event: .decrement)
        bloc.add(event: .decrement)
        XCTAssertEqual(bloc.state, initalState - 4)
    }
    
    func testBLoCEventReset() throws {
        let bloc = getBloc()
        // Test the state value of after reset
        bloc.add(event: .reset)
        XCTAssertEqual(bloc.state, 0)
    }
    
    func testBLoNoStateChangeError() throws {
        let bloc = getBloc()
        // Test the state value of after reset
        bloc.add(event: .reset)
        bloc.add(event: .reset)
        XCTAssertEqual(bloc.state, 0)
    }
}
