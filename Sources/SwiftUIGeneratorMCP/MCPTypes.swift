//
//  File.swift
//  SwiftUIGeneratorMCP
//
//  Created by Manoj Aher on 28/12/25.
//

import Foundation

// MARK: - MCPRequest
struct MCPRequest: Codable {
    let jsonrpc: String
    let id: Int?
    let method: String
    let params: [String: AnyCodable]?
}

// MARK: - MCPResponse
struct MCPResponse: Codable {
    let jsonrpc: String
    let id: Int?
    let result: [String: AnyCodable]?
    let error: MCPError?
}

// MARK: - MCPError
struct MCPError: Codable {
    let code: Int
    let message: String
}

// MARK: - ToolDefinition
struct ToolDefinition: Codable {
    let name: String
    let description: String
    let inputSchema: [String: AnyCodable]
}

// MARK: - ToolResult
struct ToolResult: Codable {
    let content: [ContentBlock]
    let isError: Bool?
}

// MARK: - ContentBlock
struct ContentBlock: Codable {
    let type: String
    let text: String
}


// MARK: - AnyCodable
struct AnyCodable: Codable {
    let value: Any
    
    init(_ value: Any) {
        self.value = value
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let int = try? container.decode(Int.self) {
            value = int
        } else if let double = try? container.decode(Double.self) {
            value = double
        } else if let string = try? container.decode(String.self) {
            value = string
        } else if let bool = try? container.decode(Bool.self) {
            value = bool
        } else if let array = try? container.decode([AnyCodable].self) {
            value = array.map { $0.value }
        } else if let dict = try? container.decode([String: AnyCodable].self) {
            value = dict.mapValues { $0.value }
        } else {
            value = NSNull()
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch value {
        case let int as Int:
            try container.encode(int)
        case let double as Double:
            try container.encode(double)
        case let string as String:
            try container.encode(string)
        case let bool as Bool:
            try container.encode(bool)
        case let array as [Any]:
            try container.encode(array.map { AnyCodable($0) })
        case let dict as [String: Any]:
            try container.encode(dict.mapValues { AnyCodable($0) })
        default:
            try container.encodeNil()
        }
    }
}
