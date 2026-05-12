//
//  LeagueDetailsServiceTests.swift
//  ArenaTests
//
//  Created by Abdelrahman on 12/05/2026.
//

import Foundation
import XCTest
import Alamofire
@testable import Arena

import Foundation
import XCTest
import Alamofire
@testable import Arena

final class LeagueDetailsServiceTests: XCTestCase {
    var service: LeagueDetailsService!
    var mockClient: MockApiClient!

    override func setUp() {
        super.setUp()
        mockClient = MockApiClient()
        service = LeagueDetailsService(apiClient: mockClient)
    }

    override func tearDown() {
        service = nil
        mockClient = nil
        super.tearDown()
    }

    private func makeLeague(sport: Sport) -> League {
        League(key: "1", name: "Test League", sport: sport, country: "Egypt", imageUrl: "", isFavorite:false)
    }

    private func makeTeamItem() -> TeamItemResponse {
        TeamItemResponse(teamKey: 1, teamName: "Arsenal", teamLogo: nil)
    }

    private func makeFootballEvent() -> FootballEventResponse {
        FootballEventResponse(
            eventHomeTeam: "Arsenal",
            eventAwayTeam: "Chelsea",
            homeTeamLogo: nil,
            awayTeamLogo: nil,
            eventFinalResult: "1-0",
            eventStatus: "Finished",
            eventDate: "2026-05-10",
            eventTime: "20:00"
        )
    }

    private func makeBasketballEvent() -> BasketballEventResponse {
        BasketballEventResponse(
            eventHomeTeam: "Lakers",
            eventAwayTeam: "Bulls",
            homeTeamLogo: nil,
            awayTeamLogo: nil,
            eventFinalResult: "102-98",
            eventStatus: "Finished",
            eventDate: "2026-05-10",
            eventTime: "18:00"
        )
    }

    private func makeTennisEvent() -> TennisEventResponse {
        TennisEventResponse(
            firstPlayer: "Nadal",
            secondPlayer: "Djokovic",
            firstPlayerLogo: nil,
            secondPlayerLogo: nil,
            eventFinalResult: "3-1",
            eventStatus: "Finished",
            eventDate: "2026-05-10",
            eventTime: "15:00"
        )
    }

    private func makeCricketEvent() -> CricketEventResponse {
        CricketEventResponse(
            eventHomeTeam: "India",
            eventAwayTeam: "Australia",
            homeTeamLogo: nil,
            awayTeamLogo: nil,
            homeFinalResult: "280",
            awayFinalResult: "250",
            eventStatus: "Finished",
            eventDate: "2026-05-10",
            eventTime: "10:00"
        )
    }

    func testFetchTeams_Success() {
        let league = makeLeague(sport: .football)
        mockClient.result = .success(TeamsResponseModel(result: [makeTeamItem()]))

        service.fetchTeams(league) { result in
            switch result {
            case .success(let teams):
                XCTAssertEqual(teams.count, 1)
                XCTAssertEqual(teams.first?.name, "Arsenal")
                XCTAssertEqual(teams.first?.leagueName, league.name)
                XCTAssertEqual(teams.first?.countryName, league.country)
            case .failure:
                XCTFail("Expected success but got failure")
            }
        }
    }

    func testFetchTeams_Failure() {
        let league = makeLeague(sport: .football)
        mockClient.result = .failure(NSError(domain: "network", code: 500))

        service.fetchTeams(league) { result in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error):
                XCTAssertEqual((error as NSError).code, 500)
            }
        }
    }

    func testFetchEvents_Football_Success() {
        let league = makeLeague(sport: .football)
        mockClient.result = .success(FootballFixturesResponse(result: [makeFootballEvent()]))

        service.fetchEvents(league) { result in
            switch result {
            case .success(let events):
                XCTAssertEqual(events.count, 1)
                XCTAssertEqual(events.first?.homeTeam.name, "Arsenal")
                XCTAssertEqual(events.first?.awayTeam.name, "Chelsea")
            case .failure:
                XCTFail("Expected success but got failure")
            }
        }
    }

    func testFetchEvents_Football_Failure() {
        let league = makeLeague(sport: .football)
        mockClient.result = .failure(NSError(domain: "network", code: 404))

        service.fetchEvents(league) { result in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error):
                XCTAssertEqual((error as NSError).code, 404)
            }
        }
    }

    func testFetchEvents_Basketball_Success() {
        let league = makeLeague(sport: .basketball)
        mockClient.result = .success(BasketballFixturesResponse(result: [makeBasketballEvent()]))

        service.fetchEvents(league) { result in
            switch result {
            case .success(let events):
                XCTAssertEqual(events.count, 1)
                XCTAssertEqual(events.first?.homeTeam.name, "Lakers")
            case .failure:
                XCTFail("Expected success but got failure")
            }
        }
    }

    func testFetchEvents_Basketball_Failure() {
        let league = makeLeague(sport: .basketball)
        mockClient.result = .failure(NSError(domain: "network", code: 404))

        service.fetchEvents(league) { result in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error):
                XCTAssertEqual((error as NSError).code, 404)
            }
        }
    }

    func testFetchEvents_Tennis_Success() {
        let league = makeLeague(sport: .tennis)
        mockClient.result = .success(TennisFixturesResponse(result: [makeTennisEvent()]))

        service.fetchEvents(league) { result in
            switch result {
            case .success(let events):
                XCTAssertEqual(events.count, 1)
                XCTAssertEqual(events.first?.homeTeam.name, "Nadal")
            case .failure:
                XCTFail("Expected success but got failure")
            }
        }
    }

    func testFetchEvents_Tennis_Failure() {
        let league = makeLeague(sport: .tennis)
        mockClient.result = .failure(NSError(domain: "network", code: 404))

        service.fetchEvents(league) { result in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error):
                XCTAssertEqual((error as NSError).code, 404)
            }
        }
    }

    func testFetchEvents_Cricket_Success() {
        let league = makeLeague(sport: .cricket)
        mockClient.result = .success(CricketFixturesResponse(result: [makeCricketEvent()]))

        service.fetchEvents(league) { result in
            switch result {
            case .success(let events):
                XCTAssertEqual(events.count, 1)
                XCTAssertEqual(events.first?.homeTeam.name, "India")
            case .failure:
                XCTFail("Expected success but got failure")
            }
        }
    }

    func testFetchEvents_Cricket_Failure() {
        let league = makeLeague(sport: .cricket)
        mockClient.result = .failure(NSError(domain: "network", code: 404))

        service.fetchEvents(league) { result in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error):
                XCTAssertEqual((error as NSError).code, 404)
            }
        }
    }
}
