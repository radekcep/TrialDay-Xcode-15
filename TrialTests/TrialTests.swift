//
//  Copyright © 2022 Erste Group Bank AG. All rights reserved.
//

import XCTest
@testable import Trial

class TrialTests: XCTestCase {
    
    func testTransactionParsing() {
        let api = TransactionsAPI()

        let expectation = XCTestExpectation(description: "Load transactions")
        
        api.loadTransactions { result in
            switch result {
            case .success(let transactions):
                XCTAssertEqual(45, transactions.count)
            case .failure(_):
                break
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
}
