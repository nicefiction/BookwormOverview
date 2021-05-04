// MARK: UsingSizeClassses_Part1.swift
/**
 SOURCE :
 https://www.hackingwithswift.com/books/ios-swiftui/using-size-classes-with-anyview-type-erasure
 */

import SwiftUI



struct UsingSizeClassses_Part1: View {
    
     // ////////////////////////
    //  MARK: PROPERTY WRAPPERS
    
    @Environment(\.presentationMode) var presentationMode
    @State private var isShowingSheet: Bool = false
    
    
    
     // //////////////////////////
    //  MARK: COMPUTED PROPERTIES
    
    var body: some View {
        
        VStack {
            Button("Tap Me") {
                isShowingSheet.toggle()
            }
            .sheet(isPresented: $isShowingSheet) {
                Text("Hello World")
                Button("Dismiss") {
                    isShowingSheet.toggle()
                    presentationMode.wrappedValue.dismiss()
                }
                .padding()
            }
            /**
             This approach allows SwiftUI to make sure
             the correct state is updated
             when the view is dismissed
             — if we attached an `@State` property to present the sheet , for example ,
             it would be set back to `false` when the sheet was dismissed .
             */
        }
    }
}





 // ///////////////
//  MARK: PREVIEWS

struct UsingSizeClassses_Part1_Previews: PreviewProvider {
    
    static var previews: some View {
        
        UsingSizeClassses_Part1()
    }
}
