//
//  UserService.swift
//  mojitok-nft
//
//  Created by 김진우 on 2022/06/23.
//

import Foundation

import RxSwift

enum UserEvent {
    case add(User)
    case delete(User)
    case update(User)
}

final class UserService {
    static let userCacheFolderURL = FilesManager.cacheFolderURL.appendingPathComponent("userS", isDirectory: true)
    static let userCacheFileURL = userCacheFolderURL.appendingPathComponent("User.txt")
    
    static let shared: UserService = .init()
    
    let event: PublishSubject<UserEvent> = .init()
    
    private var users: [User] = []
    
    private init() {
        FilesManager.checkDirectory(url: UserService.userCacheFolderURL)
        users = fetch()
        if users.isEmpty {
            let newUser = initUser()
            add(newUser)
            users = [newUser]
        }
    }
    
    func getUsers() -> [User] {
        return users
    }
    
    func fetch() -> [User] {
        if let data = try? Data(contentsOf: UserService.userCacheFileURL),
           let users = try? JSONDecoder().decode([User].self, from: data) {
            return users
        }
        return []
    }
    
    func add(_ user: User) {
        var users = fetch()
        users.insert(user, at: 0)
        overWrite(users)
        event.onNext(.add(user))
    }
    
    func delete(_ user: User) {
        var users = fetch()
        if let index = users.firstIndex(where: { $0.id == user.id }) {
            users.remove(at: index)
            overWrite(users)
            event.onNext(.delete(user))
        }
    }
    
    func update(_ user: User) {
        var users = fetch()
        if let index = users.firstIndex(where: { $0.id == user.id }) {
            users[index] = user
            self.users = users
            overWrite(users)
            event.onNext(.update(user))
        }
    }
    
    private func initUser() -> User {
        return .init()
    }
    
    private func overWrite(_ users: [User]) {
        if let data = try? JSONEncoder().encode(users) {
            try? data.write(to: UserService.userCacheFileURL)
        }
    }
}
