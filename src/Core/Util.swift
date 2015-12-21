//
//  Util.swift
//  src
//
//  Created by Anil Kumar BP on 12/21/15.
//  Copyright (c) 2015 Anil Kumar BP. All rights reserved.
//

import Foundation

public class Util {
    
    
    /// func jsonToString()
    ///
    /// @param: json        Json Object
    /// @response           String
    static func jsonToString(json: [String: AnyObject]) -> String {
        var result = "{"
        var delimiter = ""
        for key in json.keys {
            result += delimiter + "\"" + key + "\":"
            var item: AnyObject? = json[key]
            if let check = item as? String {
                result += "\"" + check + "\""
            } else {
                if let check = item as? [String: AnyObject] {
                    result += jsonToString(check)
                } else if let check = item as? [AnyObject] {
                    result += "["
                    delimiter = ""
                    for item in check {
                        result += "\n"
                        result += delimiter + "\""
                        result += item.description + "\""
                        delimiter = ","
                    }
                    result += "]"
                } else {
                    result += item!.description
                }
            }
            delimiter = ","
        }
        result = result + "}"
        return result
    }
}