//
//  DataProvider.swift
//  SurfTestTask
//
//  Created by алексей ганзицкий on 04.08.2023.
//

import Foundation

protocol DataProvider {
    func modelForProfileCell() -> ProfileContainerCellModel
    func provideCurrentTags() -> [String]
}

final class DataProviderHardcodedImpl: DataProvider {
    private var tags = [String]()
    func provideCurrentTags() -> [String] {
        ["first", "second"]
    }

    func modelForProfileCell() -> ProfileContainerCellModel {
        .init(name: "name".localized, description: "experience".localized)
    }
}

final class DataProviderUserDefaultsImpl: DataProvider {
    func provideCurrentTags() -> [String] {
        []
    }
    private let userDefaults: UserDefaults

    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
    func modelForProfileCell() -> ProfileContainerCellModel {
        ProfileContainerCellModel( name: "", description: "")
    }
}
