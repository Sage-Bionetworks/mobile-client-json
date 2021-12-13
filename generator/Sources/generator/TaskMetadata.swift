//
//  TaskMetadata.swift
//  
//
//  Copyright © 2021 Sage Bionetworks. All rights reserved.
//
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided that the following conditions are met:
//
// 1.  Redistributions of source code must retain the above copyright notice, this
// list of conditions and the following disclaimer.
//
// 2.  Redistributions in binary form must reproduce the above copyright notice,
// this list of conditions and the following disclaimer in the documentation and/or
// other materials provided with the distribution.
//
// 3.  Neither the name of the copyright holder(s) nor the names of any contributors
// may be used to endorse or promote products derived from this software without
// specific prior written permission. No license is granted to the trademarks of
// the copyright holders even if such marks are included in this software.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
// FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
// DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
// SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
// CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
// OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

import Foundation
import Research
import JsonModel

struct TaskMetadata : Codable, DocumentableStruct {

    private enum CodingKeys: String, CodingKey, CaseIterable {
        case deviceInfo, deviceTypeIdentifier, appName, appVersion, rsdFrameworkVersion, taskIdentifier, taskRunUUID, startDate, endDate, schemaIdentifier, schemaRevision, versionString, files
    }

    /// Information about the specific device.
    public let deviceInfo: String

    /// Specific model identifier of the device.
    /// - example: "Apple Watch Series 1"
    public let deviceTypeIdentifier: String

    /// The name of the application.
    public let appName: String

    /// The application version.
    public let appVersion: String

    /// Research framework version.
    public let rsdFrameworkVersion: String

    /// The identifier for the task.
    public let taskIdentifier: String

    /// The task run UUID.
    public let taskRunUUID: UUID?

    /// The timestamp for when the task was started.
    public let startDate: Date

    /// The timestamp for when the task was ended.
    public let endDate: Date

    /// The identifier for the schema associated with this task result.
    public let schemaIdentifier: String?

    /// The revision for the schema associated with this task result.
    public let schemaRevision: Int?

    /// The version string associated with this task.
    public let versionString: String?

    /// A list of the files included in this package of results.
    public let files: [FileManifest]
    
    static func examples() -> [TaskMetadata] {
        [.init(deviceInfo: "Unknown",
               deviceTypeIdentifier: "Unknown",
               appName: "Test App",
               appVersion: "1.0",
               rsdFrameworkVersion: "4.1",
               taskIdentifier: "baroo",
               taskRunUUID: UUID(),
               startDate: Date(),
               endDate: Date(),
               schemaIdentifier: "Baroo_2D",
               schemaRevision: nil,
               versionString: "1.1",
               files: FileManifest.examples())]
    }
    
    static func codingKeys() -> [CodingKey] {
        CodingKeys.allCases
    }
    
    static func isRequired(_ codingKey: CodingKey) -> Bool {
        guard let key = codingKey as? CodingKeys else { return false }
        let requiredKeys: [CodingKeys] = [.deviceInfo, .deviceTypeIdentifier, .appName, .appVersion, .taskIdentifier,.files]
        return requiredKeys.contains(key)
    }
    
    static func documentProperty(for codingKey: CodingKey) throws -> DocumentProperty {
        guard let key = codingKey as? CodingKeys else {
            throw DocumentableError.invalidCodingKey(codingKey, "\(codingKey) is not handled by \(self).")
        }
        switch key {
        case .deviceInfo:
            return .init(propertyType: .primitive(.string), propertyDescription: "Information about the specific device.")
        case .deviceTypeIdentifier:
            return .init(propertyType: .primitive(.string), propertyDescription: "Specific model identifier of the device.")
        case .appName:
            return .init(propertyType: .primitive(.string), propertyDescription: "The name of the application.")
        case .appVersion:
            return .init(propertyType: .primitive(.string), propertyDescription: "The application version.")
        case .rsdFrameworkVersion:
            return .init(propertyType: .primitive(.string), propertyDescription: "The version of the SageResearch framework.")
        case .taskIdentifier:
            return .init(propertyType: .primitive(.string), propertyDescription: "The Task Identifier for the assessment.")
        case .taskRunUUID:
            return .init(propertyType: .format(.uuid), propertyDescription: "The task run UUID.")
        case .startDate:
            return .init(propertyType: .format(.dateTime), propertyDescription: "The timestamp for when the task was started.")
        case .endDate:
            return .init(propertyType: .format(.dateTime), propertyDescription: "The timestamp for when the task was ended.")
        case .schemaIdentifier:
            return .init(propertyType: .primitive(.string), propertyDescription: "The identifier for the schema associated with this task result.")
        case .schemaRevision:
            return .init(propertyType: .primitive(.string), propertyDescription: "The revision for the schema associated with this task result.")
        case .versionString:
            return .init(propertyType: .primitive(.string), propertyDescription: "The version string associated with this task.")
        case .files:
            return .init(propertyType: .referenceArray(FileManifest.self), propertyDescription: "A list of the files included in this package of results.")
        }
    }
}

/// A manifest for a given file that includes the filename, content type, and creation timestamp.
struct FileManifest : Codable, DocumentableStruct {
    private enum CodingKeys: String, CodingKey, CaseIterable {
        case filename, timestamp, contentType, identifier, stepPath
    }
    
    /// The filename of the archive object. This should be unique within the manifest. It may include
    /// a relative path that points to a subdirectory.
    public let filename: String
    
    /// The file creation date.
    public let timestamp: Date
    
    /// The content type of the file.
    public let contentType: String?
    
    /// The identifier for the result. This value may *not* be unique if a step is run more than once
    /// during a task at different stages.
    public let identifier: String?
    
    /// The full path to the result if it is within the step history.
    public let stepPath: String?
    
    static func examples() -> [FileManifest] {
        [.init(filename: "foo", timestamp: Date(), contentType: "application/json", identifier: "foo", stepPath: "baroo/foo")]
    }
    
    static func codingKeys() -> [CodingKey] {
        CodingKeys.allCases
    }
    
    static func isRequired(_ codingKey: CodingKey) -> Bool {
        guard let key = codingKey as? CodingKeys else { return false }
        return key == .filename || key == .timestamp
    }
    
    static func documentProperty(for codingKey: CodingKey) throws -> DocumentProperty {
        guard let key = codingKey as? CodingKeys else {
            throw DocumentableError.invalidCodingKey(codingKey, "\(codingKey) is not handled by \(self).")
        }
        switch key {
        case .filename:
            return .init(propertyType: .primitive(.string), propertyDescription: "The filename of the archive object. This should be unique within the manifest. It may include a relative path that points to a subdirectory.")
        case .timestamp:
            return .init(propertyType: .format(.dateTime), propertyDescription: "The file creation date.")
        case .contentType:
            return .init(propertyType: .primitive(.string), propertyDescription: "The content type of the file.")
        case .identifier:
            return .init(propertyType: .primitive(.string), propertyDescription: "The identifier for the result. This value may *not* be unique if a step is run more than once during a task at different stages.")
        case .stepPath:
            return .init(propertyType: .primitive(.string), propertyDescription: "The full path to the result if it is within the step history.")
        }
    }
}
