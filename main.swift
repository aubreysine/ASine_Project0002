//
//  main.swift
//  ASine_Project02
//
//  Created by Aubrey on 2/25/21.
//
import Foundation
class Program{
    init(){
        
        var dictionary: [String:String] =
            ["Twitter": "Password3",
             "Facebook": "Password01",
             "Instagram": "Password"]
        
        var reply = ""
        var reply1 = ""
        var keepRunning = true
        var passwords = ""
        var deletes = ""
        var onePassword=""
        
        
        
        while keepRunning{
            //ask a question
            //check if keeo running
            //if not change keepRunning to false
            //file = File.writeJSON(dictionary: dictionary)
            reply = Ask.askQuestion(questionText: "Do you want to keep running the app", accetpableReplies: ["1","2","3","4","5"])
            
            var menu = true
                        
            while menu{
                //ask a question
                //check if keeo running
                //if not change keepRunning to false
                reply1 = Ask.askQuestion(questionText: "Would you like to 1. View all password names? 2. View a single password? 3. Delete a password? ", accetpableReplies: ["1","2","3","4","5"])
                switch reply1{
                case "1":
                    print(Edit.readAllPasswords(dictionary: dictionary))
                case "2":
                    onePassword = Edit.readSinglePassword(dictionary: dictionary)
                    print(onePassword)
                case "3":
                    dictionary = Edit.deletePassword(dictionary: dictionary)
                case "4":
                    dictionary = Edit.AddPassword(dictionary: dictionary)
                default:
                    print("Invalid input")
                }
       
            }
        }
    }
}
let p = Program()

class Ask
{
    static func askQuestion(questionText output: String,accetpableReplies inputArr: [String], caseSensitive: Bool = false) -> String
    {
        print(output) // out question
        
        //handle response
        guard let response = readLine() else
        {
            print("Invalid Input")
            return askQuestion(questionText: output, accetpableReplies: inputArr)
        }
        //verify that the response is acceptable
        //or that we dont care what the response is
        if(inputArr.contains(response)||inputArr.isEmpty)
        {
            return response
        }
        else
        {
            print("Invalid Input")
            return askQuestion(questionText: output, accetpableReplies: inputArr)
        }
    }
}

class File
{
    static func printJSON(dictionary: [String:String]) -> [String:String]
    {
        do{
            let fileURL = try FileManager.default
            .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent("mybadpasswords.json")

        try JSONSerialization.data(withJSONObject: dictionary)
            .write(to: fileURL)
        } catch{
            print(error)
        }
        return dictionary
    }
    static func writeJSON(dictionary: [String:String]) -> [String:String]
    {
        do{
            let fileURL = try FileManager.default
            .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("mybadpasswords.json")

            let data = try Data(contentsOf: fileURL)
            let dictionary = try JSONSerialization.jsonObject(with: data)
        } catch{
            print(error)
        }
        return dictionary

    }
    

}
 

class Edit
{
    
    static func reverseInput(input: String) -> String
    {
        return String(input.reversed())
    }


    // Read all passwords
    static func readAllPasswords(dictionary: [String:String]) -> [String:String]{
        return dictionary
    }
    
    // Read single password
    static func readSinglePassword(dictionary: [String:String]) -> String{
        var reply1 = " "
        reply1 = Ask.askQuestion(questionText: "What password would you like to view?", accetpableReplies: ["Twitter","Facebook","Instagram"])
        for (key, value) in dictionary {
            if(reply1 == key){
                return value
            }
        }
        return "Invalid Key"
    }
    
    // delete password
    static func deletePassword(dictionary: [String:String]) -> [String:String]{
        var reply2 = " "
        var dictionary = dictionary
        reply2 = Ask.askQuestion(questionText: "What password would you like to delete?", accetpableReplies: ["Twitter","Facebook","Instagram"])
        for (key, value) in dictionary {
            if(reply2 == key){
                // delete key and value
                dictionary[key] = nil
                return dictionary
            }
        }
        return dictionary
    }
    
    static func AddPassword(dictionary: [String:String]) -> [String:String]{
        var reply1 = " "
        var reply2 = ""
        var reply3 = ""
        var dictionary = dictionary
        reply1 = Ask.askQuestion(questionText: "What password would you like to add?", accetpableReplies: ["Apple","BetFast"])
        reply2 = Ask.askQuestion(questionText: "What password would you likethe password to be", accetpableReplies: ["Password","Password One"])
        reply3 = Ask.askQuestion(questionText: "What password would you likethe paraprhase to be", accetpableReplies: ["Aubrey","Eric"])
        reply2.append(reply3)
        reply2 = reverseInput(input: reply2)
        dictionary[reply1] = reply2
        return dictionary
    }
}

/*
class Encode{
    var str = "what the hell is going on"
    var strShift = ""
    var shift = str.count

    for letter in str{
        shrShift += String(translate(1: letter, trans:shift))
    }
    print(strShift)

    func translate(1: Character, trans: Int) -> Character
    {
        if let ascii = 1.asciiValue
        {
            var outputInt = ascii
            if ascii >= 97 && ascii <= 122
            {
                outputInt = ((ascii-97+ UInt8(trans))%26)+97
            }
            else if ((Intascii>= 65) && ascii<= 90)
            {
                outputInt = ((ascii-65+UInt8(trans))%26)+65
            }
            return Character(unicodeScalar(outputInt))
        }
    }
}
 */

