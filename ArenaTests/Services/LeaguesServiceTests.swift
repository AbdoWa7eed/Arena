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

    private func makeLeagueItem(key: String = "1", name: String = "Premier League", country: String = "England") -> LeagueItemResponse {
        LeagueItemResponse(leagueKey: key, leagueName: name, countryName: country, leagueLogo: nil)
    }

    func testFetchLeagues_Success() {
        let expectation = expectation(description: "fetchLeagues succeeds")
        mockClient.result = .success(LeagueResponseModel(success: 1, result: [makeLeagueItem()]))

        service.fetchLeagues(sport: .football) { result in
            switch result {
            case .success(let leagues):
                XCTAssertEqual(leagues.count, 1)
                XCTAssertEqual(leagues.first?.name, "Premier League")
                XCTAssertEqual(leagues.first?.country, "England")
            case .failure:
                XCTFail("Expected success but got failure")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }

    func testFetchLeagues_ReturnsMultipleLeagues() {
        let expectation = expectation(description: "fetchLeagues returns multiple")
        mockClient.result = .success(LeagueResponseModel(success: 1, result: [
            makeLeagueItem(key: "1", name: "Premier League"),
            makeLeagueItem(key: "2", name: "La Liga", country: "Spain"),
            makeLeagueItem(key: "3", name: "Serie A", country: "Italy")
        ]))

        service.fetchLeagues(sport: .football) { result in
            switch result {
            case .success(let leagues):
                XCTAssertEqual(leagues.count, 3)
            case .failure:
                XCTFail("Expected success but got failure")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }

    func testFetchLeagues_Failure() {
        let expectation = expectation(description: "fetchLeagues fails")
        mockClient.shouldFail = true

        service.fetchLeagues(sport: .football) { result in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error):
                XCTAssertEqual((error as NSError).code, 500)
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }
}
