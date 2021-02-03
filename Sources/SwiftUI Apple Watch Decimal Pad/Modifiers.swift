//
//  Modifiers.swift
//  TestDecimilKeyboard WatchKit Extension
//
//  Created by Ian Applebaum on 2/2/21.
//

import Foundation
import SwiftUI

@available(iOS 13.0, watchOS 6.0, *)
public struct DigitButtonModifier: ViewModifier {
	public func body(content: Content) -> some View {
		return content
			.buttonStyle(DigitPadStyle())
			
	}
}

@available(iOS 13.0, watchOS 6.0, *)
public extension Button {
	func digitKeyFrame() -> some View {
		self.modifier(DigitButtonModifier())
	}
}
@available(iOS 13.0, watchOS 6.0, *)
public struct DigitPadStyle: ButtonStyle {
	public func makeBody(configuration: Configuration) -> some View {
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

@available(iOS 13.0, watchOS 6.0, *)
struct TextViewStyle: ButtonStyle {
	func makeBody(configuration: Configuration) -> some View {
		GeometryReader { geometry in
			HStack {
				Spacer()
				configuration.label
				Spacer()
			}
			.background(ZStack{
				RoundedRectangle(cornerRadius: 10, style: .continuous)
					.fill(configuration.isPressed ? Color.gray.opacity(0.7): Color.gray.opacity(0.5))
//					.frame(width: geometry.size.width,height:geometry.size.height)
					.padding()
			})
//				.frame(width: geometry.size.width)
			
		}
	}
}
