//
//  Logger.swift
//  DoodleMaker
//
//  Created by Libra Studio, Inc. on 2015/06/09.
//  Copyright (c) 2015年 Libra Studio, Inc. All rights reserved.
//

import Foundation

class Logger {
    class func log(_ message: String,
                   function: String = #function,
                   file: String = #file,
                   line: Int = #line) {

        var filename = file
        if let match = filename.range(of: "[^/]*$", options: .regularExpression) {
            filename = filename.substring(with: match)
        }
        print("Log:\(filename):L\(line):\(function) \"\(message)\"")
    }
}
