//
//  ContentView.swift
//  ExTCA
//
//  Created by 강동영 on 5/26/25.
//

import SwiftUI
import ComposableArchitecture

struct NumberFactClient {
  var fetch: (Int) async throws -> String
}

extension NumberFactClient: DependencyKey {
  static let liveValue = Self(
    fetch: { number in
      let (data, _) = try await URLSession.shared
        .data(from: URL(string: "http://numbersapi.com/\(number)")!
      )
      return String(decoding: data, as: UTF8.self)
    }
  )
}

extension DependencyValues {
  var numberFact: NumberFactClient {
    get { self[NumberFactClient.self] }
    set { self[NumberFactClient.self] = newValue }
  }
}

struct ContentView: View {
    @Dependency(\.numberFact) var numberfact
    let store: StoreOf<Feature>
    
    var body: some View {
        Form {
            Section {
                Text("\(store.count)")
                Button("Decrement") {
                    store.send(.decrementButtonTapped) }
                Button("Increment") { store.send(.incrementButtonTapped) }
            }
            
            Section {
                Button("Number fact") { store.send(.numberFactButtonTapped) }
            }
            
            if let fact = store.numberFact {
                Text(fact)
            }
        }
    }
}

#Preview {
    ContentView(store: Store(initialState: Feature.State(), reducer: {
        Feature()
    }))
}

@Reducer
struct Feature {
    @ObservableState
    struct State: Equatable {
        var count = 0
        var numberFact: String?
    }
    enum Action {
        case decrementButtonTapped
        case incrementButtonTapped
        case numberFactButtonTapped
        case numberFactResponse(String)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .decrementButtonTapped:
                state.count -= 1
                return .none
            case .incrementButtonTapped:
                state.count += 1
                return .none
            case .numberFactButtonTapped:
                return .run { [count = state.count] send in
                    let (data, _) = try await URLSession.shared.data(
                        from: URL(string: "http://numbersapi.com/\(count)/trivia")!
                    )
                    await send(
                        .numberFactResponse(String(decoding: data, as: UTF8.self))
                    )
                }
            case let .numberFactResponse(fact):
                state.numberFact = fact
                return .none
            }
        }
    }
}

@Reducer
struct Feature2 {
    @ObservableState
    struct State {
        var count = 0
        var numberFact: String?
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
//        case decrementButtonTapped
//        case incrementButtonTapped
//        case numberFactButtonTapped
//        case numberFactResponse(String)
    }
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
                
            case .binding(\.count):
                return .none
            case .binding(\.numberFact):
                return .none
            case .binding(_):
                return .none
            }
        }
    }
}

@propertyWrapper
struct Wrapper<Value> {
    private let keyPath: KeyPath<WrapperValue, Value> & Sendable
    var wrappedValue: Value
    
    
    init(_ keyPath: KeyPath<WrapperValue, Value> & Sendable, _ wrappedValue: Value) {
        self.keyPath = keyPath
        self.wrappedValue = wrappedValue
    }
}

struct WrapperValue {
    
}
extension WrapperValue {
    var name: String {
        "name"
    }
}
func aaa() {
//    @Wrapper(\.name) var name
}
