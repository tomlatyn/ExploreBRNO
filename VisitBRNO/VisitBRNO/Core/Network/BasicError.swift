//
//  BasicError.swift
//  VisitBRNO
//
//  Created by Tomáš Latýn on 03.05.2025.
//

import Foundation

public typealias StatusCode = Int

public enum AuthError: Error {
    case tokenInvalid(file: String = #file, line: Int = #line, _ message: String = "")
    case tokenExpired(file: String = #file, line: Int = #line, _ message: String = "")
}

public enum ConnectionError: Error {
    case timeout(file: String = #file, line: Int = #line, _ message: String = "")
}

public enum GeneralError: Error {
    case notFound(file: String = #file, line: Int = #line, _ mesage: String = "")
    case unknown(file: String = #file, line: Int = #line, _ message: String = "")
}

public enum MappingError: Error {
    case decoding(file: String = #file, line: Int = #line, _ message: String)
    case encoding(file: String = #file, line: Int = #line, _ message: String)
    case unexpectedNil(file: String = #file, line: Int = #line, _ message: String)
}

public enum RequestError: Error {
    case response(code: StatusCode, file: String = #file, line: Int = #line, _ message: String = "")
}
