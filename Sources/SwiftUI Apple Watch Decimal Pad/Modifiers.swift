//
//  Modifiers.swift
//  TestDecimilKeyboard WatchKit Extension
//
//  Created by Ian Applebaum on 2/2/21.
//

import Foundation
import SwiftUI
struct DigitButtonModifier: ViewModifier {
	func body(content: Content) -> some View {
		return content
			.buttonStyle(DigitPadStyle())
			
	}
}
extension Button {
	func digitKeyFrame() -> some View {
		self.modifier(DigitButtonModifier())
	}
}

struct DigitPadStyle: ButtonStyle {
	func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.padding(1)
			.background(
				ZStack {
				RoundedRectangle(cornerRadius: 10, style: .continuous)
					.fill(configuration.isPressed ? Color.gray.opacity(0.7) : Color.gray.opacity(0.5))
					.frame(width: configuration.isPressed ? 60.0 : 50.0, height: configuration.isPressed ? 40.0 : 30.0)
				}
			)
			.frame(width: 50.0, height: 30.0)
	}
}
