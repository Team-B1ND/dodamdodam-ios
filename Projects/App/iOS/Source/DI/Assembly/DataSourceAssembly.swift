//
//  DataSourceAssembly.swift
//  DodamDodam
//
//  Created by Mercen on 3/28/24.
//

import Swinject
import DataSource
import Network
import Local

struct DataSourceAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(AuthDataSource.self) {
            .init(remote: $0.resolve(AuthRemote.self)!)
        }.inObjectScope(.container)
        
        container.register(BannerDataSource.self) {
            .init(remote: $0.resolve(BannerRemote.self)!)
        }.inObjectScope(.container)
        
        container.register(BusDataSource.self) {
            .init(remote: $0.resolve(BusRemote.self)!)
        }.inObjectScope(.container)
        
        container.register(MealDataSource.self) {
            .init(remote: $0.resolve(MealRemote.self)!)
        }.inObjectScope(.container)
        
        container.register(LocalMealDataSource.self) {
            .init(mealCache: $0.resolve(MealCache.self)!)
        }.inObjectScope(.container)
        
        container.register(MemberDataSource.self) {
            .init(remote: $0.resolve(MemberRemote.self)!)
        }.inObjectScope(.container)
        
        container.register(NightStudyDataSource.self) {
            .init(remote: $0.resolve(NightStudyRemote.self)!)
        }.inObjectScope(.container)
        
        container.register(NoticeDataSource.self) {
            .init(remote: $0.resolve(NoticeRemote.self)!)
        }.inObjectScope(.container)
        
        container.register(OutGoingDataSource.self) {
            .init(remote: $0.resolve(OutGoingRemote.self)!)
        }.inObjectScope(.container)
        
        container.register(OutSleepingDataSource.self) {
            .init(remote: $0.resolve(OutSleepingRemote.self)!)
        }.inObjectScope(.container)
        
        container.register(PointDataSource.self) {
            .init(remote: $0.resolve(PointRemote.self)!)
        }.inObjectScope(.container)
        
        container.register(ScheduleDataSource.self) {
            .init(remote: $0.resolve(ScheduleRemote.self)!)
        }.inObjectScope(.container)
        
        container.register(UploadDataSource.self) {
            .init(remote: $0.resolve(UploadRemote.self)!)
        }.inObjectScope(.container)
        
        container.register(WakeupSongDataSource.self) {
            .init(remote: $0.resolve(WakeupSongRemote.self)!)
        }.inObjectScope(.container)
    }
}
