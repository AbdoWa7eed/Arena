//
//  LeaguesServiceTests.swift
//  ArenaTests
//
//  Created by Abdelrahman on 12/05/2026.
//

import XCTest
import Alamofire
@testable import Arena

final class LeaguesServiceTests: XCTestCase {
    var service: LeaguesService!
    var mockClient: MockApiClient!

    override func setUp() {
        super.setUp()
        mockClient = MockApiClient()
        service = LeaguesService(apiClient: mockClient)
    }

    override func tearDown() {
        service = nil
        mockClient = nil
        super.tearDown()
    }


    func testFetchLeagues_Success() {
        let item = LeagueItemResponse(
            leagueKey: "1",
            leagueName: "Premier League",
            countryName: "England",
            leagueLogo: nil
        )
        mockClient.result = .success(LeagueResponseModel(success: 1, result: [item]))


        service.fetchLeagues(sport: .football) { result in
            switch result {
            case .success(let leagues):
                XCTAssertEqual(leagues.count, 1)
                XCTAssertEqual(leagues.first?.name, "Premier League")
            case .failure:
                XCTFail("Expected success but got failure")
            }
        }
    }


    func testFetchLeagues_Failure() {
        let expectedError = NSError(domain: "network", code: 404, userInfo: nil)
        mockClient.result = .failure(expectedError)

        service.fetchLeagues(sport: .football) { result in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error):
                XCTAssertEqual((error as NSError).code, 404)
            }
        }
    }
}
