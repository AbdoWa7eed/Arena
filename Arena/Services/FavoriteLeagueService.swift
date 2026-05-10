//
//  FavoriteLeagueService.swift
//  Arena
//
//  Created by Abdelrahman on 10/05/2026.
//

import Foundation
import CoreData
protocol FavoriteLeagueServiceProtocol {

    func saveLeague(_ league: League)

    func fetchLeagues() -> [League]

    func deleteLeague(withKey key: String)

    func isFavorite(key: String) -> Bool
    
    
}

final class FavoriteLeagueService: FavoriteLeagueServiceProtocol {

    private let persistenceController: PersistenceController

    init(persistenceController: PersistenceController) {
        self.persistenceController = persistenceController
    }


    func saveLeague(_ league: League) {
        
        guard !isFavorite(key: league.key) else {
            return
        }

        let entity = persistenceController.create(LeagueEntity.self)
        entity.update(from: league)

        persistenceController.save()
    }


    func fetchLeagues() -> [League] {

        let request: NSFetchRequest<LeagueEntity> =
            LeagueEntity.fetchRequest()

        return persistenceController
            .fetch(request: request)
            .map { $0.toLeague() }
    }


    func deleteLeague(withKey key: String) {

        let request: NSFetchRequest<LeagueEntity> =
            LeagueEntity.fetchRequest()

        request.predicate =
            NSPredicate(format: "key == %@", key)

        guard let entity =
            persistenceController.find(request: request)
        else { return }

        persistenceController.delete(entity)

        persistenceController.save()
    }


    func isFavorite(key: String) -> Bool {

        let request: NSFetchRequest<LeagueEntity> =
            LeagueEntity.fetchRequest()

        request.predicate =
            NSPredicate(format: "key == %@", key)

        return persistenceController.find(request: request) != nil
    }
    
}
