//
//  AppEnvironment.swift
//  TCA Demo
//
//  Created by hattori tsubasa on 2021/07/30.
//

import ComposableArchitecture


//依存対象の切り出し
struct AppEnvironment {
    var mainQueue: AnySchedulerOf<DispatchQueue>
    //カウンタの値を引数にアラートに表示する文字列を作るクロージャです。
    var numberFact: (Int) -> Effect<String, ApiError>
}
