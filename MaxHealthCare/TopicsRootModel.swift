//
//  TopicsRootModel.swift
//  MaxHealthCare
//
//  Created by VJ on 22/02/24.
//

import Foundation

// MARK: - RootResponse
struct RootResponse: Codable {
    let result: Result

    enum CodingKeys: String, CodingKey {
        case result = "Result"
    }
}

// MARK: - Result
struct Result: Codable {
    let error: String
    let total: Int
    let language: String
    let resources: Resources

    enum CodingKeys: String, CodingKey {
        case error = "Error"
        case total = "Total"
        case language = "Language"
        case resources = "Resources"
    }
}

// MARK: - Resources
struct Resources: Codable {
    let resource: [Resource]

    enum CodingKeys: String, CodingKey {
        case resource = "Resource"
    }
}

// MARK: - Resource
struct Resource: Codable {
    let type, id, title, imageURL: String
    let relatedItems: RelatedItems
    let sections: Sections
    let healthfinderLogo, healthfinderURL: String

    enum CodingKeys: String, CodingKey {
        case type = "Type"
        case id = "Id"
        case title = "Title"
        case imageURL = "ImageUrl"
        case relatedItems = "RelatedItems"
        case sections = "Sections"
        case healthfinderLogo = "HealthfinderLogo"
        case healthfinderURL = "HealthfinderUrl"
    }
}

// MARK: - RelatedItems
struct RelatedItems: Codable {
    let relatedItem: [RelatedItem]

    enum CodingKeys: String, CodingKey {
        case relatedItem = "RelatedItem"
    }
}

// MARK: - RelatedItem
struct RelatedItem: Codable {
    let type, id, title, url: String

    enum CodingKeys: String, CodingKey {
        case type = "Type"
        case id = "Id"
        case title = "Title"
        case url = "Url"
    }
}

// MARK: - Sections
struct Sections: Codable {
    let section: [Section]
}

// MARK: - Section
struct Section: Codable {
    let title: String?
    let content: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case content = "Content"
    }
}
