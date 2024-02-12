//
//  URL+Extension.swift
//  DessertMeals
//
//  Created by Michael Wilkowski on 2/6/24.
//

import Foundation

extension URL: Identifiable {
    public var id: String { self.absoluteString }
}
