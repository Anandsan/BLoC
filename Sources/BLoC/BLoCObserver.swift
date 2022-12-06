//
//  BLoCObserver.swift
//  
//
//  Created by Sankaran, Anand on 12/2/22.
//

import Foundation

public protocol BLoCObserver {
    func onCreate<Event, State>(bloc: BLoC<Event, State>)
    func onEvent<Event, State>(bloc: BLoC<Event, State>, event: Event)
    func onTransition<Event, State>(bloc: BLoC<Event, State>, transition: Transition<Event, State>)
    func onError<Event, State>(bloc: BLoC<Event, State>, error: Error)
    func onClose<Event, State>(bloc: BLoC<Event, State>)
}
