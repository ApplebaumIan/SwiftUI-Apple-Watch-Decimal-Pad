//
//  Modifiers.swift
//  TestDecimilKeyboard WatchKit Extension
//
//  Created by Ian Applebaum on 2/2/21.
//

import Foundation
import SwiftUI
#if os(watchOS)
import WatchKit
#endif
@available(watchOS 6.0, *)
public struct DigitButtonModifier: ViewModifier {
	public func body(content: Content) -> some View {
		return content
			.buttonStyle(DigitPadStyle())
			
	}
}

//@available(iOS 13.0, watchOS 6.0, *)
//public struct TextTrailingAlignmentModifier: ViewModifier{
//	public typealias Body = DigiTextView
//
//	public func body(content: Content) -> DigiTextView {
//		return content.setAlign
//	}
//
//
//}
//
//public extension DigiTextView{
//	func alignTextTrailing() -> some View {
//		self.modifier(TextTrailingAlignmentModifier())
//	}
//}

@available(watchOS 6.0, *)
public extension Button {
	func digitKeyFrame() -> some View {
		self.modifier(DigitButtonModifier())
	}
}
@available(watchOS 6.0, *)
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
			.onChange(of: configuration.isPressed, perform: { value in
				if configuration.isPressed{
					DispatchQueue.main.async {
                        #if os(watchOS)
                        WKInterfaceDevice().play(.click)
                        #endif
					}
				}
			})
	}
}

public enum TextViewAlignment {
	case trailing
	case leading
	case center
}

