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
        GeometryReader(content: { geometry in
            configuration.isPressed ?
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color.gray.opacity(0.7))
                .frame(width: configuration.isPressed ? geometry.size.width/0.75 : geometry.size.width, height: configuration.isPressed ? geometry.size.height/0.8 : geometry.size.height)
                :
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color.gray.opacity(0.5))
                .frame(width: configuration.isPressed ? geometry.size.width/0.75 : geometry.size.width, height: configuration.isPressed ? geometry.size.height/0.8 : geometry.size.height)
            
            configuration.label
                .padding(1)
                .background(
                    ZStack {
                        GeometryReader(content: { geometry in
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(Color.clear)
                                .frame(width: configuration.isPressed ? geometry.size.width/0.75 : geometry.size.width, height: configuration.isPressed ? geometry.size.height/0.8 : geometry.size.height)
                            
                        })
                        
                        
                    }
                )
                .frame(width: geometry.size.width, height: geometry.size.height)
        })
//            Spacer()
			
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

public enum KeyboardStyle {
    case decimil
    case numbers
}
#if DEBUG
struct EnteredTextKeys_Previews: PreviewProvider {
    static var previews: some View {
        EnteredText( text: .constant(""), presentedAsModal: .constant(true), style: .numbers)
        Group {
            EnteredText( text: .constant(""), presentedAsModal: .constant(true), style: .decimil)
            EnteredText( text: .constant(""), presentedAsModal: .constant(true), style: .decimil)
                .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
        }
        EnteredText( text: .constant(""), presentedAsModal: .constant(true), style: .decimil).previewDevice("Apple Watch Series 6 - 40mm")
        EnteredText( text: .constant(""), presentedAsModal: .constant(true), style: .numbers).previewDevice("Apple Watch Series 3 - 38mm")
        EnteredText( text: .constant(""), presentedAsModal: .constant(true), style: .decimil).previewDevice("Apple Watch Series 3 - 42mm")
    }
}
#endif
