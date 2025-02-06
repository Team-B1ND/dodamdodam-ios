//
//  RepositoryAssembly.swift
//  DodamDodam
//
//  Created by Mercen on 3/28/24.
//

import Swinject
import Repository
import DataSource
import Domain

struct RepositoryAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register((any AuthRepository).self) {
            AuthRepositoryImpl(dataSource: $0.resolve(AuthDataSource.self)!)
        }.inObjectScope(.container)
        
        container.register((any BannerRepository).self) {
            BannerRepositoryImpl(dataSource: $0.resolve(BannerDataSource.self)!)
        }.inObjectScope(.container)
        
        container.register((any BusRepository).self) {
            BusRepositoryImpl(dataSource: $0.resolve(BusDataSource.self)!)
        }.inObjectScope(.container)
        
        container.register((any DivisionRepository).self) {
            DivisionRepositoryImpl(dataSource: $0.resolve(DivisionDataSource.self)!)
        }.inObjectScope(.container)
        
        container.register((any MealRepository).self) {
            MealRepositoryImpl(
                dataSource: $0.resolve(MealDataSource.self)!,
                localDataSource: $0.resolve(LocalMealDataSource.self)!
            )
        }.inObjectScope(.container)
        
        container.register((any MemberRepository).self) {
            MemberRepositoryImpl(dataSource: $0.resolve(MemberDataSource.self)!)
        }.inObjectScope(.container)
        
        container.register((any NightStudyRepository).self) {
            NightStudyRepositoryImpl(dataSource: $0.resolve(NightStudyDataSource.self)!)
        }.inObjectScope(.container)
        
        container.register((any OutGoingRepository).self) {
            OutGoingRepositoryImpl(dataSource: $0.resolve(OutGoingDataSource.self)!)
        }.inObjectScope(.container)
        
        container.register((any OutSleepingRepository).self) {
            OutSleepingRepositoryImpl(dataSource: $0.resolve(OutSleepingDataSource.self)!)
        }.inObjectScope(.container)
        
        container.register((any PointRepository).self) {
            PointRepositoryImpl(dataSource: $0.resolve(PointDataSource.self)!)
        }.inObjectScope(.container)
        
        container.register((any ScheduleRepository).self) {
            ScheduleRepositoryImpl(dataSource: $0.resolve(ScheduleDataSource.self)!)
        }.inObjectScope(.container)
        
        container.register((any UploadRepository).self) {
            UploadRepositoryImpl(dataSource: $0.resolve(UploadDataSource.self)!)
        }.inObjectScope(.container)
        
        container.register((any WakeupSongRepository).self) {
            WakeupSongRepositoryImpl(dataSource: $0.resolve(WakeupSongDataSource.self)!)
        }.inObjectScope(.container)
    }
}
