//
//  IdentifierableExt.swift
//  Shared
//
//  Created by hhhello0507 on 2/14/25.
//

import Foundation

public extension Array where Element: Identifiable {
    func findElement(id: Element.ID) -> Element? {
        guard let index = self.findIndex(id: id) else { return nil }
        return self[index]
    }
    
    func findIndex(id: Element.ID) -> Int? {
        return self.firstIndex { $0.id == id }
    }
}
