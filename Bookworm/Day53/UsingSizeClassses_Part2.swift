// MARK: UsingSizeClassses_Part2.swift
/**
 SOURCE :
 https://www.hackingwithswift.com/books/ios-swiftui/using-size-classes-with-anyview-type-erasure
 
 The environment is packed full of interesting things we can read to help make our apps work better .
 In this project
 we are going to be using the environment to work with Core Data ,
 but here I’m going to show you another important use for it : size classes .
 _Size classes_ are Apple’s thoroughly vague way of telling us
 how much space we have for our views .
 When I say “thoroughly vague” I mean it :
 we have only two size classes horizontally and vertically ,
 called _compact_ and _regular_ .
 That’s it – that covers all screen sizes
 from the largest iPad Pro in landscape
 down to the smallest iPhone in portrait.
 That doesn’t mean it is useless – far from it! –
 just that it only lets us reason about our user interfaces in the broadest terms .
 */

import SwiftUI



struct UsingSizeClassses_Part2: View {
    
     // ////////////////////////
    //  MARK: PROPERTY WRAPPERS
    
    @Environment(\.horizontalSizeClass) var sizeClass
    
    
    
     // //////////////////////////
    //  MARK: COMPUTED PROPERTIES
    
    var body: some View {
        
        if sizeClass == .compact {
            HStack {
                Text("Active Size Class :")
                Text("COMPACT")
            }
            .font(.title)
        } else {
            HStack {
                Text("Active Size Class :")
                Text("REGULAR")
            }
            .font(.title)
        }
    }
}





 // ///////////////
//  MARK: PREVIEWS

struct UsingSizeClassses_Part2_Previews: PreviewProvider {
    
    static var previews: some View {
        
        UsingSizeClassses_Part2()
    }
}
