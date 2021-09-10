//
//  ContentView.swift
//  TestDecimilKeyboard WatchKit Extension
//
//  Created by Ian Applebaum on 2/2/21.
//

import SwiftUI

@available(watchOS 6.0, *)
public struct DigiTextView: View {
    var style: KeyboardStyle
	var placeholder: String
	@Binding public var text: String
	@State public var presentingModal: Bool
	
	var align: TextViewAlignment
    public init( placeholder: String, text: Binding<String>, presentingModal:Bool, alignment: TextViewAlignment = .center,style: KeyboardStyle = .numbers){
		_text = text
		_presentingModal = State(initialValue: presentingModal)
		self.align = alignment
		self.placeholder = placeholder
        self.style = style
	}
	
	public var body: some View {
		Button(action: {
			presentingModal.toggle()
		}) {
			if text != ""{
                Text(text)
			}
			else{
				Text(placeholder)
					.lineLimit(1)
					.opacity(0.5)
			}
		}.buttonStyle(TextViewStyle(alignment: align))
		.sheet(isPresented: $presentingModal, content: {
            EnteredText(text: $text, presentedAsModal: $presentingModal, style: self.style)
		})		
	}
}
@available(watchOS 6.0, *)
public struct EnteredText: View {
	@Binding var text:String
	@Binding var presentedAsModal: Bool
    var style: KeyboardStyle
	public init(text: Binding<String>, presentedAsModal:
                    Binding<Bool>, style: KeyboardStyle){
		_text = text
		_presentedAsModal = presentedAsModal
        self.style = style
	}
	public var body: some View{
		VStack(alignment: .trailing) {
			Spacer()
			Spacer()
			
			Button(action:{
				presentedAsModal.toggle()
			}){
				Text(text)
			}
			.buttonStyle(PlainButtonStyle())
			.multilineTextAlignment(.trailing)
			.lineLimit(1)
			.frame(width: 160, height: 15, alignment: .trailing)
				
            DigetPadView(text: $text, style: style)

		}
//		.edgesIgnoringSafeArea(.all
//		)
        .toolbar(content: {
            ToolbarItem(placement: .cancellationAction){
                Button("Done"){
                    presentedAsModal.toggle()
                }
            }
        })
	}
}
@available(iOS 13.0, watchOS 6.0, *)
 public struct DigetPadView: View {
	public var widthSpace: CGFloat = 4.0
	@Binding var text:String
    var style: KeyboardStyle
    public init(text: Binding<String>, style: KeyboardStyle){
		_text = text
        self.style = style
	}
	 public var body: some View {
		VStack(spacing: 5) {
			HStack(spacing: widthSpace){
				Button(action: {
					text.append("1")
				}) {
					Text("1")
						.padding(0)
				}
				.digitKeyFrame()
				Button(action: {
					text.append("2")
				}) {
					Text("2")
				}.digitKeyFrame()
				
				Button(action: {
					text.append("3")
				}) {
							Text("3")
						}.digitKeyFrame()
			}
			HStack(spacing:widthSpace){
				Button(action: {
					text.append("4")
				}) {
					Text("4")
				}.digitKeyFrame()
				Button(action: {
					text.append("5")
				}) {
					Text("5")
				}.digitKeyFrame()
				
				Button(action: {
					text.append("6")
				}) {
					Text("6")
				}.digitKeyFrame()
			}
			
			HStack(spacing:widthSpace){
				Button(action: {
					text.append("7")
				}) {
					Text("7")
				}.digitKeyFrame()
				Button(action: {
					text.append("8")
				}) {
					Text("8")
				}.digitKeyFrame()
				
				Button(action: {
					text.append("9")
				}) {
					Text("9")
				}
				.digitKeyFrame()
			}
			HStack(spacing:widthSpace) {
                if style == .decimil {
                    Button(action: {
                        if !(text.contains(".")){
                            if text == ""{
                                text.append("0.")
                            }else{
                                text.append(".")
                            }
                        }
                    }) {
                        Text("•")
                    }
                    .digitKeyFrame()
                } else {
                    Spacer()
                }
				Button(action: {
					text.append("0")
				}) {
					Text("0")
				}
				.digitKeyFrame()
				
				Button(action: {
					if let last = text.indices.last{
						text.remove(at: last)
					}
				}) {
					Image(systemName: "delete.left")
				}
				.digitKeyFrame()
				//
			}
			
			
			//				.padding()
		}
//		.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
		//		.padding(10.0)
		//		.frame(width: 150.0, height: 50.0)
	}
}


//struct DigetView_Previews: PreviewProvider {
//	static var previews: some View {
////		DigetPadView( text: "b")
//	}
//}
#if DEBUG
struct EnteredText_Previews: PreviewProvider {
	static var previews: some View {
        EnteredText( text: .constant(""), presentedAsModal: .constant(true), style: .numbers)
	}
}

struct Content_View_Previews: PreviewProvider {
	static var previews: some View{
		ScrollView {
			ForEach(0 ..< 4) { item in
				DigiTextView(placeholder: "Placeholder", text: .constant(""), presentingModal: false, alignment: .leading)
			}
			Button(action: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/{}/*@END_MENU_TOKEN@*/) {
				/*@START_MENU_TOKEN@*//*@PLACEHOLDER=Content@*/Text("Button")/*@END_MENU_TOKEN@*/
			}
		}
	}
}

struct TextField_Previews: PreviewProvider {
	static var previews: some View{
		ScrollView{
			ForEach(0 ..< 4){ item in
				TextField(/*@START_MENU_TOKEN@*/"Placeholder"/*@END_MENU_TOKEN@*/, text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
			}
			Button(action: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/{}/*@END_MENU_TOKEN@*/) {
				/*@START_MENU_TOKEN@*//*@PLACEHOLDER=Content@*/Text("Button")/*@END_MENU_TOKEN@*/
			}
		}
	}
}
#endif
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
					.padding(.vertical, 11.0)
					.padding(.horizontal)
				if align == .center || align == .leading{
				Spacer()
				}
			}
			.background(
				GeometryReader { geometry in
					ZStack{
				RoundedRectangle(cornerRadius: 7, style: .continuous)
					.fill(configuration.isPressed ? Color.gray.opacity(0.1): Color.gray.opacity(0.2))
					}
			})
			
	}
	
}
