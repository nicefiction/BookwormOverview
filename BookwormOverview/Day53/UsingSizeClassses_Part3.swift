// MARK: UsingSizeClassses_Part3.swift
/**
 SOURCE :
 https://www.hackingwithswift.com/books/ios-swiftui/using-size-classes-with-anyview-type-erasure
 */

import SwiftUI



struct UsingSizeClassses_Part3: View {
    
    // ////////////////////////
    //  MARK: PROPERTY WRAPPERS
    
    @Environment(\.horizontalSizeClass) var sizeClass
    
    
    
    // //////////////////////////
    //  MARK: COMPUTED PROPERTIES
    
    var body: some View {
        
        /* OLIVIER :
         * This works just fine ,
         * there is no need to use AnyView here :
         
         if sizeClass == .compact {
         VStack(alignment : .leading) {
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
         */
        /**
         `PAUL HUDSON`:
         When you build the code you’ll see an ominous error :
         — `OLIVIER`: I do not get the error message —
         “Function declares an opaque return type,
         but the return statements in its body do not have matching underlying types .”
         That is ,
         the `some View` return type of `body`
         requires that one single type is returned from all paths in our code
         – we can’t sometimes return one view and other times return something else .
         */
        if sizeClass == .compact {
            AnyView(VStack(alignment : .leading) {
                Text("Active Size Class :")
                Text("COMPACT")
            }
            .font(.title))
        } else {
            AnyView(HStack {
                Text("Active Size Class :")
                Text("REGULAR")
            }
            .font(.title))
        }
        /**
         We have wrapped both our stacks in a new view type called `AnyView` ,
         which is what is called a `type erased wrapper` .
         `AnyView` conforms to the same `View` protocol as
         `Text` , `Color` , `VStack`, and more ,
         and it also contains inside it a view of a specific type .
         However , externally `AnyView` doesn’t expose what it contains
         — Swift sees our condition as returning either an `AnyView` or an `AnyView` ,
         so it is considered the same type .
         This is where the name _type erasure_ comes from :
         `AnyView` effectively hides – or erases – the type of the views it contains .
         
         `GOOD PRACTICE`:
         Now , the logical conclusion here is
         to ask _why we don’t use `AnyView` all the time_
         _if it lets us avoid the restrictions of some View ?_
         The answer is simple : performance .
         When SwiftUI knows exactly what is in our view hierarchy ,
         it can add and remove small parts trivially as needed ,
         but when we use `AnyView`
         we are actively denying SwiftUI that information .
         As a result , it is likely to have to do significantly more work
         to keep our user interface updated when regular changes happen ,
         so it is generally best to avoid `AnyView` unless you specifically need it .
         */
    }
}




 // ///////////////
//  MARK: PREVIEWS

struct UsingSizeClassses_Part3_Previews: PreviewProvider {
    
    static var previews: some View {
        
        UsingSizeClassses_Part3()
    }
}
