import Foundation
import JsonModel
import MotorControl
import Research
import MobilePassiveData

func buildJson() {
    let factory = MCTFactory()
    let baseUrl = factory.jsonSchemaBaseURL
    let downloadsDirectory = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first!
    let schemasDirectory = baseUrl.pathComponents.dropFirst().reduce(downloadsDirectory, { $0.appendingPathComponent($1) })
    let examplesDirectory = baseUrl.pathComponents.dropFirst().reduce(downloadsDirectory, {
        $0.appendingPathComponent($1 == "schemas" ? "examples" : $1)
    })

    let fileManager = FileManager.default
    
    do {
        try fileManager.createDirectory(at: schemasDirectory, withIntermediateDirectories: true, attributes: nil)
        try fileManager.createDirectory(at: examplesDirectory, withIntermediateDirectories: true, attributes: nil)
        
        let doc = JsonDocumentBuilder(factory: factory)

        let docs = try doc.buildSchemas()
        let encoder = factory.createJSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes]

        try docs.forEach { (doc) in
        
            let json = try encoder.encode(doc)
            
            guard let schemaURL = doc.id.url
            else {
                fatalError("Doc path is not a valid URL: \(doc.id.classPath)")
            }
            
            let url = schemasDirectory.appendingPathComponent(schemaURL.lastPathComponent)
            try json.write(to: url)
            print(url)
            
            guard let definitions = doc.definitions?.values else {
                print("Definitions is nil for \(doc.id)")
                return
            }
                            
            try definitions.forEach { (definition) in
                guard case .object(let value) = definition,
                    let interfaces = value.allOf,
                    interfaces.contains(where: { $0.ref == "#"}),
                    let examples = value.examples,
                    let className = value.className
                else {
                    return
                }
                
                try examples.enumerated().forEach { (index, ex) in
                    let example = ex.dictionary
                    let subdir = examplesDirectory.appendingPathComponent("\(doc.id.className)")
                    try fileManager.createDirectory(at: subdir, withIntermediateDirectories: true, attributes: nil)
                    let filename = "\(className)_\(index).json"
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

buildJson()
