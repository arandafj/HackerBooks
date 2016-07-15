//
//  JSONProcessing.swift
//  HackerBooks
//
//  Created by CLAG on 29/6/16.
//  Copyright © 2016 Clag. All rights reserved.
//

import UIKit

enum JSONKeys : String {
    case authors   = "authors"
    case image_url = "image_url"
    case pdf_url   = "pdf_url"
    case tags      = "tags"
    case title     = "title"
    
}

enum JSONProcessingError : ErrorType{
    case wrongURLFormatForJSONResource
    case resourcePointedByURLNotReachable
    case jsonParsingError
    case wrongJSONFormat
    case nilJSONObject
}

typealias JSONObject     = AnyObject
typealias JSONDictionary = [String : JSONObject]
typealias JSONArray      = [JSONDictionary]


func decode(book json: JSONDictionary) throws -> Book {
    
    guard let imageUrlString = json[JSONKeys.image_url.rawValue] as?  String else{
        throw JSONProcessingError.resourcePointedByURLNotReachable
    }
    
    let imageData = try getFile(imageUrlString)
    
    guard let pdfUrlString = json[JSONKeys.pdf_url.rawValue] as? String else{
        throw JSONProcessingError.resourcePointedByURLNotReachable
    }
    
    let pdfData = try getFile(pdfUrlString)
    
    guard let title = json[JSONKeys.title.rawValue] as? String else{
        throw JSONProcessingError.wrongJSONFormat
    }
    
    guard let tagsString = json[JSONKeys.tags.rawValue] as? String else {
        throw JSONProcessingError.wrongJSONFormat
    }
    
    var tags = tagsString.stringByReplacingOccurrencesOfString(", ", withString: ",", options: NSStringCompareOptions.LiteralSearch, range: nil).componentsSeparatedByString(",")
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    if var _ = defaults.objectForKey(title){
        tags.insert("Favourite", atIndex: 0)
    }
    
    guard let authorsString = json[JSONKeys.authors.rawValue] as? String else {
        throw JSONProcessingError.wrongJSONFormat
    }
    
    //Json object:
    return Book(title : title.capitalizedString,
                authors : authorsString.stringByReplacingOccurrencesOfString(", ", withString: ",", options: NSStringCompareOptions.LiteralSearch, range: nil).componentsSeparatedByString(","),
                   tags : tags,
                   image : imageData,
                   pdf : pdfData)
}


func decode(booksCollection json: JSONArray) -> Array<Book>{
    var result : Array<Book> = []
    for index in 0 ..< json.count{
        print("Book - index: \(index) - with \(json.count)")
        do{
            let book = try decode(book: json[index]);
            result.append(book)
            print(book)
            
        } catch {
            print("Error with a book - index: \(index) - error: \(error)")
        }
    }
    return result
}


func getFile(url: String) throws -> NSData{
    let cachePath = NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true)[0] as String
    let nameUrlParts = url.componentsSeparatedByString("/")
    let nameFile : String = nameUrlParts[nameUrlParts.count-1]
    let strFilePath = cachePath.stringByAppendingString(nameFile)
    
    let manager = NSFileManager.defaultManager()
    if (manager.fileExistsAtPath(strFilePath)) {
        let data = NSData(contentsOfFile: strFilePath)
        return data!
        
    }else{
        guard let Url = NSURL(string: url), data = NSData(contentsOfURL: Url) else{
            throw JSONProcessingError.resourcePointedByURLNotReachable
        }
        
        let strFilePath = cachePath.stringByAppendingString(nameFile);
        data.writeToFile(strFilePath, atomically: true)
        
        if nameFile.hasSuffix("jpg"){
            let image = UIImage(data: data)
            UIImageJPEGRepresentation(image!, 100)!.writeToFile(strFilePath, atomically: true)
        } else if nameFile.hasSuffix("png"){
            let image = UIImage(data: data)
            UIImagePNGRepresentation(image!)!.writeToFile(strFilePath, atomically: true)
        } else {
            data.writeToFile(strFilePath, atomically: true)
        }
        
        return data
    }
    
}
