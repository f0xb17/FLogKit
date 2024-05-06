// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

let flog: Flogger = Flogger(filePath: "logfile.txt")

flog.log(event: "Started Process XYZ to get user data", level: 1)
flog.log(event: "Error while getting user data: No user found", level: 2)
flog.log(event: "An User with name ABC allready exists", level: 3)
flog.log(event: "Fatal Error: Name is empty", level: 4)