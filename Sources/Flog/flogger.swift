/**
 * flogger.swift
 * Represents a simple logging library that can write all events to a corresponding file.
 *
 * Created by f0xb17 on 05/06/2024.
 * Copyright © 2024 f0xb17. All rights reserved.
 */

import Foundation

class Flogger {
    final let fileName: String
    final let dateFormatter: DateFormatter = DateFormatter()
    
    /**
    Constructor of the class, The format with which the subsequent timestamp is to be formatted is also set. 
    -   Parameter fileName: File name in which the logs are to be saved. 
    */
    init(fileName: String) {
        self.fileName = fileName
        self.dateFormatter.dateFormat = "yyyy-MM-dd | HH:mm:ss"
    }

    /**
    This function returns an error level, from FloggerLevel
    -   Parameter level: Numerical value used to determine the error level.
    -   Returns: an error level from FloggerLevel
    */
    private final func getLevel(level: Int) -> FloggerLevel {
        switch level {
            case 1:
                return FloggerLevel.Info
            case 2:
                return FloggerLevel.Error
            case 3:
                return FloggerLevel.Problem
            case 4: 
                return FloggerLevel.Exception
            default:
                return FloggerLevel.Info
        }
    }

    /**
    This function returns the desired event, with the desired FloggerLevel to the terminal.
    -   Paramter event: The message to be logged.
    -   Parameter level: A numerical value to determine the error level.
    -   Returns: a String that contains the formatted message. 
    */
    private final func eventMessage(event: String, level: Int) -> String {
        return self.dateFormatter.string(from: Date()) + ": " + String(describing: self.getLevel(level: level)) + " - " + event + "\n"
    }

    /**
    This method writes the event, with the desired FloggerLevel to the logfile. 
    -   Paramter event: The message to be logged.
    -   Parameter level: A numerical value to determine the error level.
    */
    private func write(event: String, level: Int) throws {
        let fileURL: URL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath).appendingPathComponent(self.fileName)
        do {
            if FileManager.default.fileExists(atPath: fileURL.path) {
                let fileHandle: FileHandle = try FileHandle(forWritingTo: fileURL)
                try fileHandle.seekToEnd()
                if let data: Data = self.eventMessage(event: event, level: level).data(using: .utf8) {
                    fileHandle.write(data)
                    try fileHandle.close()
                }
            } else {
                try self.eventMessage(event: event, level: level).write(to: fileURL, atomically: true, encoding: .utf8)
            }
        } catch {
            print(self.eventMessage(event: error.localizedDescription, level: 4))
        }
    }

    /**
    This method calls the write function.
    -   Paramter event: The message to be logged.
    -   Parameter level: A numerical value to determine the error level.
    */
    final func log(event: String, level: Int) {
        do {
            try self.write(event: event, level: level)
        } catch {
            print(self.eventMessage(event: error.localizedDescription, level: 4))
        }
    }

}