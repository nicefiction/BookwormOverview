// MARK: ContentView.swift
/**
 SOURCE :
 https://www.hackingwithswift.com/books/ios-swiftui/how-to-combine-core-data-and-swiftui
 
 Core Data is (`A`) an object graph
 and (`B`) persistence framework ,
 which is a fancy way of saying
 (`A`) it lets us define
 objects
 and properties of those objects ,
 (`B`) then lets us read and write them from permanent storage .
 On the surface this sounds like using `Codable` and `UserDefaults` ,
 but it is much more advanced than that :
 `Core Data` is capable of sorting and filtering of our data ,
 and can work with much larger data
 — there is effectively no limit to how much data it can store .
 Even better , Core Data implements all sorts of more advanced functionality
 for when you really need to lean on it :
 data validation ,
 lazy loading of data ,
 undo and redo ,
 and much more .
    Setting up Core Data requires two steps :
 (`1`) creating what is called a `persistent container` ,
 which is what loads and saves the actual data from device storage ,
 and (`2`) injecting that into the SwiftUI environment
 so that all our views can access it .
 Both of these steps are already done for us by the Xcode template .
 So , what remains is
 for us to decide _what_ data we want to store in Core Data ,
 and _how_ to read it back out .
 */

import SwiftUI
import CoreData



struct ContentView: View {
    
     // ////////////////////////
    //  MARK: PROPERTY WRAPPERS
    
    /**
     ⭐️ STEP 1 of 5 ,
     Ask the `@Environment` property wrapper for the current managed object context ,
     and assign it to a property for our use :
     */
    @Environment(\.managedObjectContext) var managedObjectContext
    /**
     ⭐️ STEP 2 of 5 ,
     Retrieving information from Core Data is done using a fetch request
     — we describe what we want ,
     how it should sorted ,
     and whether any filters should be used ,
     and Core Data sends back all the matching data .
     We need to make sure that this fetch request stays up to date over time ,
     so that as students are created or removed
     our UI stays synchronized .
     SwiftUI has a solution for this , and – you guessed it – it’s another property wrapper .
     This time it is called `@FetchRequest`
     and it takes two parameters :
     the `entity` we want to query ,
     and how we want the results to be sorted .
     It has quite a specific format ,
     */
    @FetchRequest(entity : Student.entity() ,
                  sortDescriptors : []) var students: FetchedResults<Student>
    /**
     ❌
     If the code fails to build ,
     try `Product > Clean Build Folder` ,
     `Product > Build` ,
     and `restart XCode` .
     This way the object graph can fully load into the project .
     
     SOURCE :
     https://www.hackingwithswift.com/forums/100-days-of-swiftui/day-53-bookworm-use-of-undeclared-type-student-error-when-using-core-data/1265
     
     `NOTE` OLIVIER :
     I have also noticed that the ContentView won't build in the Canvas ,
     instead run the app in the Simulator , `COMMAND + R`.
     */
    
    
    
     // //////////////////////////
    //  MARK: COMPUTED PROPERTIES

    var body: some View {
        
        VStack {
            List {
                ForEach(students , id : \.id) { student in
                    Text(student.name ?? "Unknown")
                }
            }
            /**
             ⭐️ STEP 3 of 5 ,
             Add a button that generates random students
             and saves them in the managed object context :
             */
            Button("Add") {
                let firstNames: [String] = [
                    "Ginny" , "Harry" , "Hermione" , "Luna" , "Ron"
                ]
                let lastNames: [String] = [
                    "Granger" , "Lovegood" , "Potter" , "Weasley"
                ]

                let chosenFirstName = firstNames.randomElement() ?? "N/A"
                let chosenLastName = lastNames.randomElement() ?? "N/A"

                /**
                 ⭐️ STEP 4A of 5 ,
                 Create a `Student` object ,
                 using the class Core Data generated for us .
                 This needs to be attached to a _managed object context_ ,
                 so the object knows where it should be stored  :
                 */
                let student = Student(context : self.managedObjectContext)
                /**
                 ⭐️ STEP 4B of 5 ,
                 We can then assign values to it
                 just like we normally would for a struct :
                 */
                student.id = UUID()
                student.name = "\(chosenFirstName) \(chosenLastName)"
                
                /**
                 ⭐️ STEP 5 of 5 ,
                 Finally , we need to ask our managed object context to save itself :
                 */
                try? self.managedObjectContext.save()
                /**
                 `NOTE` :
                 This is a throwing function call ,
                 because in theory it might fail .
                 In practice , nothing about what we have done has any chance of failing ,
                 so we can call this using `try?` — we don’t care about catching errors .
                 */
            }
        }
    }
}





 // //////////////
// MARK: PREVIEWS

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        ContentView().environment(\.managedObjectContext ,
                                  PersistenceController
                                    .preview
                                    .container
                                    .viewContext)
    }
}
