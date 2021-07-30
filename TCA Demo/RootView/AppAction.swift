//
//  AppAction.swift
//  TCA Demo
//
//  Created by hattori tsubasa on 2021/07/30.
//

import ComposableArchitecture

enum AppAction: Equatable {

    //factAlertDismissed から numberFactButtonTapped までがプレゼンテーション層から発生するアクションです。
    case factAlertDismissed
    case decrementBtnTapped
    case incrementBtnTapped
    case numberFactBtnTapped
    //ドメイン層/データ層から発生するアクションです。
    case numberFactResponse(Result<String, ApiError>)
}


struct ApiError: Error, Equatable {}


let appReducer = Reducer<AppState, AppAction, AppEnvironment> { state, action, environment in
    switch action {
    case .factAlertDismissed:
        state.numberFaceAlert = nil
        return .none

    case .decrementBtnTapped:
        state.count -= 1
        return .none

    case .incrementBtnTapped:
        state.count += 1
        return .none

    case .numberFactBtnTapped:
        return environment.numberFact(state.count)
            .receive(on: environment.mainQueue)
            .catchToEffect()
            .map(AppAction.numberFactResponse)

    case let .numberFactResponse(.success(fact)):
        state.numberFaceAlert = fact
        return .none

    case .numberFactResponse(.failure):
        state.numberFaceAlert = "Could not load a number fact :("
        return .none
    }
}
