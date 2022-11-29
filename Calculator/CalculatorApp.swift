//
//  CalculatorApp.swift
//  Calculator
//
//  Created by 陳冠甫 on 2022/11/25.
//

import SwiftUI

@main
struct CalculatorApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(GlobalEnvironment())
        }
    }
}
