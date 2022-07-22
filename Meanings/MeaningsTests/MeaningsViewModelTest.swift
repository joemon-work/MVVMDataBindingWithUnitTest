//
//  MeaningsViewModelTest.swift
//  MeaningsTests
//
//  Created by 1964058 on 02/06/22.
//

import XCTest
@testable import Meanings

class MeaningsViewModelTest: XCTestCase {
    
    var apiManager:APIManager!
    var viewModel:MeaningsViewModel!
    var meanings:[MeaningCellViewModel]!
    var searchResults:[MeaningCellViewModel]!
    var session:MockURLSession!

    override func setUpWithError() throws {
        super.setUp()
//        viewModel = MeaningsViewModel()
//        self.searchResults = [MeaningCellViewModel]()
        session = MockURLSession()
        apiManager = APIManager(session: session)
        viewModel = MeaningsViewModel(apiManger: apiManager)
    }

    override func tearDownWithError() throws {
        super.tearDown()
        viewModel = nil
        meanings = nil
        searchResults = nil
        apiManager = nil
        session = nil
    }
    
 /*   func testApiforSearchResult() {
        
        let url = URL(string: "http://www.nactem.ac.uk/software/acromine/dictionary.py?sf=Hmm")!
        let expectation = self.expectation(description: "fetchmeanings")
        apiManager.loadData(from: url ) { result in
            switch result {
                
            case .data(let data):
                do {
                    var meanings = [MeaningCellViewModel]()
                    let meaning:[Meaning] = try JSONDecoder().decode([Meaning].self, from: data)
                    if !meaning.isEmpty {
                        var lfs:[lfs] = []
                        if let first = meaning.first, let meanings = first.lfs {
                            lfs = meanings
                        }
                        for item in lfs {
                            meanings.append(MeaningCellViewModel(meaningText: item.lf))
                        }
                        self.searchResults = meanings
                        expectation.fulfill()
                    }
                } catch _ {
                    XCTFail("Failed due to Parse Error")
                    return
                }
            case .error(_):
                XCTFail("Fail due to Error")
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertEqual(searchResults.count, 0)
    }*/
    
    func testGetSearchData() {
        do {
            session.dummyData = try getData(fromJSON: "Meanings")
        } catch let error {
            print(error.localizedDescription)
        }
        viewModel.fetchMeaning(with: "Hmm")
        XCTAssertEqual(viewModel.meanings.value?.count, 8)
    }
    
//    func testFetchMeaningWithSearchResult() {
//        let expectation = self.expectation(description: "fetchmeanings")
//        viewModel.fetchMeaning(with: "Hmm") { status,errorMessage, searchResult in
//            if status {
//                self.searchResults = searchResult
//                expectation.fulfill()
//            }
//        }
//        waitForExpectations(timeout: 10, handler: nil)
//        XCTAssertEqual(searchResults.count, 8)
//    }
//
//    func testFetchMeaningWithNoResult() {
//            let expectation = self.expectation(description: "fetchmeanings")
//            viewModel.fetchMeaning(with: "U") { status,errorMessage, searchResult  in
//                if status {
//                } else {
//                    self.searchResults = []
//                    expectation.fulfill()
//                }
//            }
//            waitForExpectations(timeout: 10, handler: nil)
//            XCTAssertEqual(searchResults.count, 0)
//    }

}

