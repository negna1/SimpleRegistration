//
//  String + Extension.swift
//  PetProject
//
//  Created by Nato Egnatashvili on 16.02.23.
//

import Foundation

extension String {
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let providers = ["gmail.com", "hotmail.com", "outlook.com", "yahoo.com", "icloud.com"]
        let components = self.components(separatedBy: "@")
        if components.count != 2 { return false }
        if !providers.contains(where: {$0 == components[1]}) { return false }
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    
    func isPaswordValid() -> Bool {
        return self.count < 12 && self.count > 6
    }
}
