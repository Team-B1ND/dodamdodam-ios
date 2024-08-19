import Swinject

public class DependencyProvider {
    
    public static let shared = DependencyProvider()
    
    public let container = Container()
}
