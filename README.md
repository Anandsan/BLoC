## About

This BLoC library is the state management tool using the design pattern of the BLoC (Business logic component) approach to separate views and business logic. 

Requires iOS 13.0+ and MacOS 10.15+

## Start

The app emits the event and based on the event, the state of view will update. **BLoC** is the tool to track events and map them into the state.
Example
```swift 
enum UserEvent: Equatable {
  case enter
  case exit
}
```
Based on the above UserEvent, the app UI will show the welcome or thank you message.

```swift 
let bloc = BLoC(initialState: "") { (state: String, event:UserEvent) -> String in
    switch event {
    case .enter:
      "Welcome to the Store"
    case .exit:
      "Thank you for visiting us"
    }
  }
```
In the above example, we use Enum for the event. You can implement your event as you want, which conforms to the **Equatable** protocol. 

If you need a more complex implementation to track events and map them into states, then the **BLoC** class is the choice. Consider the example of StepperView before and after BLoC.

```swift 
import SwiftUI

struct StepperView: View {
    @State private var value = 0
    
    let colors: [Color] = [.orange, .red, .gray, .blue, .green,
                           .purple, .pink]
    
    // Business logic to map the increment and decrement event
    func incrementStep() {
        value += 1
        if value >= colors.count { value = 0 }
    }
    
    func decrementStep() {
        value -= 1
        if value < 0 { value = colors.count - 1 }
    }
    
    var body: some View {
        Stepper("Value: \(value) Color: \(colors[value].description)", onIncrement: incrementStep, onDecrement: decrementStep)
        .padding(5)
        .background(colors[value])
    }
}
```
Using the BLoC, we are separating the Business Logic outside the StepperView

```swift
Import SwiftUI
import BLoC

struct StepperViewBloc: View {
    
    enum StepperEvent {
        case increment
        case decrement
    }
    
    struct ColorValue: Equatable {
        var value = 0
        private let colors: [Color] = [.orange, .red, .gray, .blue, .green,
                               .purple, .pink]
        public var max: Int {
            colors.count - 1
        }
        public var color: Color {
            colors[value]
        }
    }
    
    @StateObject var bloc = BLoC(initialState: ColorValue()) { (state: ColorValue, event:StepperEvent) -> ColorValue in
        switch event {
        case .increment: return state.value >= state.max ? ColorValue(value: 0) : ColorValue(value:state.value + 1)
        case .decrement: return state.value <= 0 ? ColorValue(value:state.max) : ColorValue(value:state.value - 1)
        }
    }

    var body: some View {
        Stepper("Value: \(bloc.state.value) Color: \(bloc.state.color.description)", onIncrement: {bloc.add(event: .increment)}, onDecrement:{ bloc.add(event: .decrement)})
        .padding(5)
        .background(bloc.state.color)
    }
}

```
## Requirements

The library supports iOS 14 & above. 

## Installation

### Cocoapods

BLoC is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'BLoC'
```
### Swift Package Manager

To install it, add the following lines to your Package.swift file
```swift
dependencies: [
    .package(url: "https://github.com/AnandSan/BLoC.git", from: "1.0.0")
]
```

## Author

Anand Sankaran, anand.sankaran.1979@gmail.com

## License

BLoC is available under the MIT license. See the LICENSE file for more info.
