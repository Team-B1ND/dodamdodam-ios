//
//  RemoteAssembly.swift
//  DodamDodam
//
//  Created by Mercen on 3/28/24.
//

import Swinject
import Network

struct RemoteAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(AuthRemote.self) { _ in
                .init()
        }.inObjectScope(.container)
        
        container.register(BannerRemote.self) { _ in
                .init()
        }.inObjectScope(.container)
        
        container.register(BusRemote.self) { _ in
                .init()
        }.inObjectScope(.container)
        
        container.register(MealRemote.self) { _ in
                .init()
        }.inObjectScope(.container)
        
        container.register(MemberRemote.self) { _ in
                .init()
        }.inObjectScope(.container)
        
        container.register(NightStudyRemote.self) { _ in
                .init()
        }.inObjectScope(.container)
        
        container.register(OutGoingRemote.self) { _ in
                .init()
        }.inObjectScope(.container)
        
        container.register(OutSleepingRemote.self) { _ in
                .init()
        }.inObjectScope(.container)
        
        container.register(PointRemote.self) { _ in
                .init()
        }.inObjectScope(.container)
        
        container.register(ScheduleRemote.self) { _ in
                .init()
        }.inObjectScope(.container)
        
        container.register(UploadRemote.self) { _ in
                .init()
        }.inObjectScope(.container)
        
        container.register(WakeupSongRemote.self) { _ in
                .init()
        }.inObjectScope(.container)
    }
}
