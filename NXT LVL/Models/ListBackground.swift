//
//  ListBackground.swift
//  NXT LVL
//
//  Created by Aleck Holly on 2022-12-13.
//

import Foundation
import SwiftUI

struct ListBackground: ViewModifier {
    func body(content: Content) -> some View {
            if #available(iOS 16.0, *) {
                content.scrollContentBackground(.hidden)
            } else {
                content
            }
        }
}

extension View {
    func clearListBackground() -> some View {
        modifier(ListBackground())
    }
}
