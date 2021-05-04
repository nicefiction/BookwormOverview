// MARK: CustomComponentWIthBinding_Part2.swift
/**
 SOURCE :
 https://www.hackingwithswift.com/books/ios-swiftui/creating-a-custom-component-with-binding
 
 What is happening here is
 that we have defined a one-way flow of data :
 `ContentView` has its `isRememberingMe Boolean`,
 which gets used to create a `CustomButton`
 — the button has an initial value provided by `ContentView` .
 However , once the button was created
 it takes over control of the value :
 it toggles the `isOn` property between `true `or `false` internally to the button ,
 but doesn’t pass that change back on to `ContentView` .
 This is a problem ,
 because we now have two sources of truth :
 `ContentView` is storing one value ,
 and `CustomButton` another .
 Fortunately , this is where `@Binding `comes in :
 it allows us to create a two-way connection between `CustomButton`
 and whatever is using it ,
 so that when one value changes
 the other does too .
 To switch over to `@Binding`
 we need to make just two changes :
 */

import SwiftUI



struct CustomButton: View {
    
     // /////////////////
    //  MARK: PROPERTIES
    
    var title: String
    var onColor: Color = Color.green
    var offColor: Color = Color.red
    
    
    
     // ////////////////////////
    //  MARK: PROPERTY WRAPPERS
    
    // @State var isOn: Bool
    @Binding var isOn: Bool // STEP 1 of 2 ⭐️
    
    
    
     // //////////////////////////
    //  MARK: COMPUTED PROPERTIES
    
    var body: some View {
        
        Button(title) {
            isOn.toggle()
        }
        .padding()
        .padding()
        .background(isOn ? onColor : offColor)
        .foregroundColor(Color.white)
        .font(.title)
        .clipShape(Capsule())
    }
}



struct CustomComponentWIthBinding_Part2: View {
    
     // ////////////////////////
    //  MARK: PROPERTY WRAPPERS
    
    @State private var isRememberingMe: Bool = false
    
    
     // //////////////////////////
    //  MARK: COMPUTED PROPERTIES
    
    var body: some View {
        
        VStack {
            CustomButton(title : isRememberingMe ? "Remember Me" : "Don't Remember Me" ,
                         // isOn : isRememberingMe)
                         isOn : $isRememberingMe) // STEP 2 of 2 ⭐️
            Text(isRememberingMe ? "ON" : "OFF")
                .padding()
                .font(.title)
        }
    }
}





 // ///////////////
//  MARK: PREVIEWS

struct CustomComponentWIthBinding_Part2_Previews: PreviewProvider {
    
    static var previews: some View {
        
        CustomComponentWIthBinding_Part2()
    }
}
