//
//  SkillsTagsManager.swift
//  SurfTestTask
//
//  Created by алексей ганзицкий on 10.08.2023.
//

import Foundation

struct SkillsTagsManager {
    static let shared = SkillsTagsManager()
    
    private let tagsKey = "tags"
    
    func saveTags(_ tags: [String]) {
        UserDefaults.standard.setValue(tags, forKey: tagsKey)
    }
    
    func loadTags() -> [String] {
        if let tagsArray = UserDefaults.standard.value(forKey: tagsKey) as? [String] {
            return tagsArray
        }
        return []
    }
}
