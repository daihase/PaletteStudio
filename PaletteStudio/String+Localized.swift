//
//  String+Localized.swift
//  PaletteStudio
//
//  Created by daihase on 2016/09/18.
//  Copyright © 2016年 Libra Studio, Inc. All rights reserved.
//

import UIKit

extension String
{
    func localized() -> String
    {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    func convertToDictionary() -> [String:AnyObject]?
    {
        if let data = self.data(using: String.Encoding.utf8) {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:AnyObject]
                return json
            } catch {
                print("Something went wrong")
            }
        }
        
        return nil
    }
}
