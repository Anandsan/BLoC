//
//  BLoCObserverLog.swift
//
//
//  Created by Sankaran, Anand on 12/2/22.
//

import Foundation

struct BLoCObserverLog {
    
    init() {}
    private func log(
        message: Any,
        file: String,
        line: Int,
        function: String,
        errorLevel: Bool = false
    ) {
        let logTime = Date()
        let place = (file as NSString).lastPathComponent
        print("[\(errorLevel ? "Error" : "Info")/\(logTime)]: [\(place):\(line) #\(function)] \(message)")
    }
    
    func logInfo(
        _ message: Any,
        file: String = #file,
        line: Int = #line,
        function: String = #function
    ) {
        log(
            message: message,
            file: file,
            line: line,
            function: function
        )
    }

    func logError(
        _ message: Any,
        file: String = #file,
        line: Int = #line,
        function: String = #function
    ) {
        log(
            message: message,
            file: file,
            line: line,
            function: function,
            errorLevel: true
        )
    }
}

extension BLoCObserverLog: BLoCObserver {
    func onCreate<Event, State>(bloc: BLoC<Event, State>) where Event : Equatable, State : Equatable {
        logInfo("OnCreate of \(bloc.description)")
    }
    
    func onEvent<Event, State>(bloc: BLoC<Event, State>, event: Event) where Event : Equatable, State : Equatable {
        logInfo("OnEvent \(event) the bloc state is \(bloc.description)")
    }
    
    func onTransition<Event, State>(bloc: BLoC<Event, State>, transition: Transition<Event, State>) where Event : Equatable, State : Equatable {
        logInfo("Ontransition \(transition.description) the bloc value is \(bloc.description)")
    }
    
    func onError<Event, State>(bloc: BLoC<Event, State>, error: Error) where Event : Equatable, State : Equatable {
        logError("OnError \(error) the bloc value is \(bloc.description)")
    }
    
    func onClose<Event, State>(bloc: BLoC<Event, State>) where Event : Equatable, State : Equatable {
        logInfo("OnClose of \(bloc.description)")
    }
}
