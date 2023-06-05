import Foundation
import JsonModel
import AssessmentModel
import ResultModel
import MotorControl

func buildJson() {
    let factory = GeneratorFactory()
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
        let encoder = factory.createJSONEncoder() as! OrderedJSONEncoder
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes]
        encoder.shouldOrderKeys = true

        try docs.forEach { (doc) in
        
            let json = try encoder.encode(doc)
            
            guard let schemaURL = doc.id.url
            else {
                fatalError("Doc path is not a valid URL: \(doc.id.classPath)")
            }
            
            let url = schemasDirectory.appendingPathComponent(schemaURL.lastPathComponent)
            try json.write(to: url)
            print(url)
            
            let subdir = examplesDirectory.appendingPathComponent("\(doc.id.className)")
            
            if let examples = doc.root.examples {
                try buildExampleFiles(examples: examples, subdir: subdir, className: doc.id.className, jsonType: doc.jsonType)
            }
            
            guard let definitions = doc.definitions?.values else {
                print("Definitions is nil for \(doc.id)")
                return
            }
                            
            try definitions.forEach { (definition) in
                guard case .object(let value) = definition,
                    let interfaces = value.allOf,
                    interfaces.contains(where: { $0.refId == nil }),
                    let examples = value.examples,
                    let className = value.className
                else {
                    return
                }
                try buildExampleFiles(examples: examples, subdir: subdir, className: className)
            }
        }
    } catch {
        fatalError("Failed to build the JsonSchema: \(error)")
    }
}

func buildExampleFiles(examples: [AnyCodableDictionary], subdir: URL, className: String, jsonType: JsonType = .object) throws {
    let fileManager = FileManager.default
    try fileManager.createDirectory(at: subdir, withIntermediateDirectories: true, attributes: nil)
    if jsonType == .array {
        try writeExample(examples.map { $0.dictionary }, subdir: subdir, className: className, index: 0)
    }
    else {
        try examples.enumerated().forEach { (index, ex) in
            try writeExample(ex.dictionary, subdir: subdir, className: className, index: index)
        }
    }
}

func writeExample(_ example: Any, subdir: URL, className: String, index: Int) throws {
    let filename = "\(className)_\(index).json"
    let url = subdir.appendingPathComponent(filename)
    let exampleJson = try JSONSerialization.data(withJSONObject: example, options: [.sortedKeys, .prettyPrinted, .withoutEscapingSlashes])
    try exampleJson.write(to: url)
    print(url)
}

buildJson()

class GeneratorFactory : AssessmentFactory {
    required init() {
        super.init()
        
        // manually add the tapping result object to the result serializer.
        self.resultSerializer.add(TappingResultObject())
        
        self.registerRootObject(ArchiveMetadata())
    }
}

