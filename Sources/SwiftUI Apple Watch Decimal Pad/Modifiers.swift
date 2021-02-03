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

public enum TextViewAlignment {
	case trailing
	case leading
	case center
}

@available(iOS 13.0, watchOS 6.0, *)
struct TextViewStyle: ButtonStyle {
	init(alignment: TextViewAlignment = .center) {
		self.align = alignment
	}
	
	
	var align: TextViewAlignment
	func makeBody(configuration: Configuration) -> some View {
			HStack {
				if align == .center || align == .trailing{
				Spacer()
				}
				configuration.label
					.font(/*@START_MENU_TOKEN@*/.body/*@END_MENU_TOKEN@*/)
					.padding()
				if align == .center || align == .leading{
				Spacer()
				}
			}
			.background(
				GeometryReader { geometry in
					ZStack{
				RoundedRectangle(cornerRadius: 5, style: .continuous)
					.fill(configuration.isPressed ? Color.gray.opacity(0.7): Color.gray.opacity(0.5))
					.frame(width: geometry.size.width, height:geometry.size.height)
					}
			})
			.padding()
			.padding(.vertical, 10.0)
//				.frame(width: geometry.size.width)
			
	}
	
}
