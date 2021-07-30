//
//  ContentView.swift
//  TCA Demo
//
//  Created by hattori tsubasa on 2021/07/30.
//

import ComposableArchitecture
import SwiftUI

struct ContentView: View {

    let store: Store<AppState, AppAction>

    var body: some View {
        WithViewStore(self.store) { (viewStore) in
            NavigationView {
                VStack {
                    HStack {
                        Button("-") { viewStore.send(.decrementBtnTapped) }
                        Text("\(viewStore.count)")
                        Button("+") {viewStore.send(.incrementBtnTapped)}
                    }

                    Button("Number Fact") {viewStore.send(.numberFactBtnTapped)}

                    NavigationLink(
                        destination: SecondView(),
                        label: {
                            Text("Todo View")
                        })
                }
                .alert(
                    item: viewStore.binding(
                        get: {$0.numberFaceAlert.map(FactAlert.init(title:))},
                        send: .factAlertDismissed
                    ),
                    content: {Alert(title: Text($0.title))}
                )
            }
        }
    }
}

struct FactAlert: Identifiable {
    var title: String
    var id: String {self.title}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(
            store: Store(initialState: AppState(),
                         reducer: appReducer,
                         environment: AppEnvironment(mainQueue: DispatchQueue.main.eraseToAnyScheduler(),
                                                     numberFact: { (number) -> Effect<String, ApiError> in
                                                        return Effect(value: "\(number) is a good number Brent")
                                                     }))
        )
    }
}

