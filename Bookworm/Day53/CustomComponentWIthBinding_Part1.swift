// MARK: CustomComponentWIthBinding_Part1.swift
/**
 SOURCE :
 https://www.hackingwithswift.com/books/ios-swiftui/creating-a-custom-component-with-binding
 
 You have already seen how SwiftUI’s `@State` property wrapper lets us work with local value types ,
 and how `@ObservedObject` lets us work with shareable reference types .
 Well , there’s a third option , called `@Binding` ,
 which lets us connect an `@State` property of one view
 to some underlying model data .
 Think about it :
 when we create a toggle switch
 we send in some sort of Boolean property
 that can be changed , like this :
 */

import SwiftUI



struct CustomComponentWIthBinding_Part1: View {
    
     // ////////////////////////
    //  MARK: PROPERTY WRAPPERS
    
    @State private var isRememberingMe: Bool = false
    
    
    
     // //////////////////////////
    //  MARK: COMPUTED PROPERTIES
    
    var body: some View {
        
        VStack {
            Toggle("Remember me :" , isOn : $isRememberingMe)
                .padding()
            
            Toggle(isRememberingMe ? "Remember me :" : "Don't remember me :" ,
                   isOn : $isRememberingMe)
                .padding()
            
            Toggle(isOn : $isRememberingMe) {
                Text(isRememberingMe ? "Remember me :" : "Don't remember me :")
                    .font(.title)
            }
            .padding()
        }
        .font(.title)
    }
    /**
     So , the toggle needs to change our Boolean when the user interacts with it ,
     but _how does it remember what value it should change ?_
     That is where `@Binding` comes in :
     it lets us create a mutable value in a view ,
     that actually points to some other value from elsewhere .
     In the case of `Toggle` ,
     the switch changes its own _local binding_ to a `Boolean`,
     but behind the scenes
     that is actually manipulating the `@State` property in our view .
        This makes `@Binding` extremely important
     for whenever you want to create a custom user interface component .
     At their core ,
     UI components are just SwiftUI views like everything else ,
     but `@Binding` is what sets them apart :
     while they might have their local `@State` properties ,
     they also expose `@Binding` properties
     that let them interface directly with other views .
     */
}





 // ///////////////
//  MARK: PREVIEWS

struct CustomComponentWIthBinding_Part1_Previews: PreviewProvider {
    
    static var previews: some View {
        
        CustomComponentWIthBinding_Part1()
    }
}
