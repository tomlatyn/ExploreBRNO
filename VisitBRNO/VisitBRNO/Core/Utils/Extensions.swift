//
//  Extensions.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 05.05.2025.
//

import Foundation

extension String {
    func decodeHTMLEntities() -> String {
        guard let data = self.data(using: .utf8) else { return self }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        let decoded = try? NSAttributedString(data: data, options: options, documentAttributes: nil)
        return decoded?.string ?? self
    }
    
    var isEmail: Bool {
        guard let regex = Constants.emailRegex else { return false }
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}
