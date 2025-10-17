
import Reachability

final class NetworkReachability {
    
    static let shared = NetworkReachability()
    private let reachability = try! Reachability()
    
    private init() {
        startNotifier()
    }
    
    private func startNotifier() {
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start Reachability notifier: \(error)")
        }
    }
    
    var isConnected: Bool {
        return reachability.connection != .unavailable
    }
    
    deinit {
        reachability.stopNotifier()
    }
}
