//
//  NXT_LVLApp.swift
//  NXT LVL
//
//  Created by Aleck Holly on 2022-12-02.
//

import SwiftUI

@main
struct NXT_LVLApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView().attachPartialSheetToRoot()
        }
    }
}
