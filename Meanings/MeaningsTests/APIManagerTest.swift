//
//  APIManagerTest.swift
//  MeaningsTests
//
//  Created by 1964058 on 02/06/22.
//

import XCTest
@testable import Meanings
class APIManagerTest: XCTestCase {
    fileprivate var baseURL = "http://www.nactem.ac.uk/software/acromine/dictionary.py?sf="
   
    var apiManger:APIManager!
    var mockSession:MockURLSession!
    
    override func setUpWithError() throws {
        super.setUp()
        mockSession = MockURLSession()
        apiManger = APIManager(session: mockSession)
    }

    override func tearDownWithError() throws {
        super.tearDown()
        mockSession = nil
        apiManger = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testApiforCorrectUrl() {
       
        if let url = URL(string: baseURL) {
            apiManger.loadData(from: url ) { result in }
        }
        if let cachedUrl = mockSession.cachedUrl {
            XCTAssertEqual(cachedUrl.host, "www.nactem.ac.uk")
        }
        
    }

}

class MockURLSession: NetworkSession {
    typealias Handler = NetworkSession.Handler
    let dummyTask = MockURLSessionDataTask()
    var dummyData:Data?
    var error:Error?
    var cachedUrl:URL?
    var response:URLResponse?
    
    func httpResponse(request: URLRequest) -> URLResponse{
            return HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: "1.1", headerFields: nil)!
        }
    
    func dataTask(with request: URLRequest, completionHandler: @escaping Handler) -> URLSessionDataTaskProtocol {
        self.cachedUrl = request.url
        completionHandler(dummyData,httpResponse(request: request),error)
        return dummyTask
    }
    
   
        
//    func loadData(from url: URL, completion: @escaping Handler) {
//        self.cachedUrl = url
//        let testBundle = Bundle(for: type(of: self))
//        guard let ressourceURL = testBundle.url(forResource: "Meanings", withExtension: "json") else {
//            return
//        }
//        do {
//            let ressourceData = try Data(contentsOf: ressourceURL)
//            self.dummyData = ressourceData
//        } catch _ {
//
//        }
//        completion(dummyData,response, error)
//    }
}
 
class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    private var isResumed = false
    func resume() {
        isResumed = true
    }
}
