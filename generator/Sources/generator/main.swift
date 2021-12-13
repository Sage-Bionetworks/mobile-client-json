import Foundation
import JsonModel
import Research

func buildJson() {
    let factory = RSDFactory()
    
    let roots: [String : (SerializationFactory, [DocumentableObject.Type])] = [
        "assessment" : (RSDFactory(), [AssessmentTaskObject.self, RSDTaskResultObject.self]),
        "metadata" : (SerializationFactory(), [TaskMetadata.self])
    ]
    
    let downloadsDirectory = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first!
    let schemasDirectory = downloadsDirectory.appendingPathComponent("AssessmentModel-JsonSchema/schemas/")
    let examplesDirectory = downloadsDirectory.appendingPathComponent("AssessmentModel-JsonSchema/examples/")

    let fileManager = FileManager.default
    
    do {
        try fileManager.createDirectory(at: schemasDirectory, withIntermediateDirectories: true, attributes: nil)
        try fileManager.createDirectory(at: examplesDirectory, withIntermediateDirectories: true, attributes: nil)
    } catch {
        fatalError("Failed to build the JsonSchema: \(error)")
    }
    
    roots.forEach { (key, value) in

        let baseUrl = URL(string: "https://raw.githubusercontent.com/Sage-Bionetworks/AssessmentModel-JsonSchema/main/schemas/")!
        
        let doc = JsonDocumentBuilder(baseUrl: baseUrl,
                                      factory: value.0,
                                      rootDocuments: value.1)

        do {
            let docs = try doc.buildSchemas()
            let encoder = factory.createJSONEncoder()
            encoder.outputFormatting = [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes]

            try docs.forEach { (doc) in
            
                let json = try encoder.encode(doc)
                
                let filename = "\(doc.id.className).json"
                let url = schemasDirectory.appendingPathComponent(filename)
                try json.write(to: url)
                print(url)
                
                guard let definitions = doc.definitions?.values else {
                    fatalError("Definitions should not be nil")
                }
                                
                try definitions.forEach { (definition) in
                    guard case .object(let value) = definition,
                        let interfaces = value.allOf,
                        interfaces.contains(where: { $0.ref.className == doc.id.className}),
                        let examples = value.examples
                    else {
                        return
                    }
                    
                    try examples.enumerated().forEach { (index, ex) in
                        let example = ex.dictionary
                        
                        let subdir = examplesDirectory.appendingPathComponent("\(doc.id.className)")
                        try fileManager.createDirectory(at: subdir, withIntermediateDirectories: true, attributes: nil)
                        let filename = "\(value.id.className)_\(index).json"
                        let url = subdir.appendingPathComponent(filename)
                        let exampleJson = try JSONSerialization.data(withJSONObject: example, options: [])
                        try exampleJson.write(to: url)
                        print(url)
                    }
                }
            }
        } catch {
            fatalError("Failed to build the JsonSchema: \(error)")
        }
    }
}

buildJson()
