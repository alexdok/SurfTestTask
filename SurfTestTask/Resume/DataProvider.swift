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
        ["gdfgdf", "gdfgdf"]
    }

    func modelForProfileCell() -> ProfileContainerCellModel {
        .init(name: "Ганзицкий Алексей \nЭдуардович", description: "junior iOS-разработчик, опыт 1 год самостоятельного обучения ")
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
        ProfileContainerCellModel( name: "Ганзицкий Алексей Эдуардович", description: "fgdgdfgdf")
    }
}
