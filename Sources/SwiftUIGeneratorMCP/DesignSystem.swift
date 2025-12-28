//
//  DesignSystem.swift
//  SwiftUIGeneratorMCP
//
//  Created by Manoj Aher on 28/12/25.
//

import Foundation

// MARK: - DesignSystem
struct DesignSystem: Codable {
    let colors: Colors
    let typography: Typography
    let spacing: Spacing
    let cornerRadius: CornerRadius
    let shadows: Shadows
    
    struct Colors: Codable {
        let primary: String
        let secondary: String
        let tertiary: String
        let background: String
        let surface: String
        let error: String
        let success: String
        let textPrimary: String
        let textSecondary: String
    }
    
    struct Typography: Codable {
        let largeTitle: String
        let title: String
        let heading: String
        let body: String
        let callout: String
        let caption: String
    }
    
    struct Spacing: Codable {
        let xs: Int
        let small: Int
        let medium: Int
        let large: Int
        let xl: Int
        let xxl: Int
    }
    
    struct CornerRadius: Codable {
        let small: Int
        let medium: Int
        let large: Int
        let xl: Int
    }
    
    struct Shadows: Codable {
        let small: ShadowConfig
        let medium: ShadowConfig
        let large: ShadowConfig
    }
    
    struct ShadowConfig: Codable {
        let radius: Int
        let opacity: Double
        let y: Int
    }
    
    // MARK: -  Load from JSON file
    static func load(from path: String) throws -> DesignSystem {
        let url = URL(fileURLWithPath: path)
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(DesignSystem.self, from: data)
    }
    
    // MARK: -  Default design system
    static let `default` = DesignSystem(
        colors: Colors(
            primary: "Color.blue",
            secondary: "Color.purple",
            tertiary: "Color.gray",
            background: "Color(.systemBackground)",
            surface: "Color(.secondarySystemBackground)",
            error: "Color.red",
            success: "Color.green",
            textPrimary: "Color.primary",
            textSecondary: "Color.secondary"
        ),
        typography: Typography(
            largeTitle: ".largeTitle",
            title: ".title",
            heading: ".headline",
            body: ".body",
            callout: ".callout",
            caption: ".caption"
        ),
        spacing: Spacing(
            xs: 4,
            small: 8,
            medium: 16,
            large: 24,
            xl: 32,
            xxl: 48
        ),
        cornerRadius: CornerRadius(
            small: 4,
            medium: 8,
            large: 12,
            xl: 16
        ),
        shadows: Shadows(
            small: ShadowConfig(radius: 2, opacity: 0.1, y: 1),
            medium: ShadowConfig(radius: 4, opacity: 0.15, y: 2),
            large: ShadowConfig(radius: 8, opacity: 0.2, y: 4)
        )
    )
}
