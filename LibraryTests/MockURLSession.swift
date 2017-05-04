//
//  MockURLSession.swift
//  Library
//
//  Created by Thakur, Angita on 5/3/17.
//  Copyright © 2017 Thakur, Angita. All rights reserved.
//

import SwiftyJSON
@testable import Library

class MockURLSession: URLSession {

    var response: JSON?
    var isSuccess: Bool = true
    var httpStatusCode: Int = 200
    var error: NSError = NSError(domain: "UnitTestsDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Testing failure through unit tests"])

    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        if isSuccess {
            completionHandler(try! response?.rawData(), nil, nil)
        }
        else {
            completionHandler(nil, nil, error)
        }
        return MockURLSessionDataTask()
    }

}

class MockURLSessionDataTask : URLSessionDataTask {

    var statusCode: Int

    init(statusCode: Int = 200) {
        self.statusCode = statusCode
        super.init()
    }

    override var response: URLResponse? {
        return HTTPURLResponse(url: URL(string: "https://www.ilovetacos.com")! , statusCode: self.statusCode, httpVersion: nil, headerFields: [String: String]())
    }

    override func resume() {
        return
    }

}
