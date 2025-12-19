import Swinject
import Domain

struct UseCaseAssembly: Assembly {

    func assemble(container: Container) {
        container.register(DeepLinkLoginUseCase.self) {
            DeepLinkLoginUseCaseImpl(
                authRepository: $0.resolve((any AuthRepository).self)!
            )
        }.inObjectScope(.container)
    }
}
