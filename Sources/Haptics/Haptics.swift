import UIKit

// MARK: - Haptics

public struct Haptics {
    
    static private var instance = Haptics()
    
    private var notificationGenerator = UINotificationFeedbackGenerator()
    private var impactGenerator: ImpactFeedbackGenerator = .init()
    
    public enum Notification {
        case success
        case warning
        case error
    }

    public enum Impact {
        case light
        case medium
        case heavy
    }
    
    func prepare() {
        notificationGenerator.prepare()
        impactGenerator.heavy.prepare()
        impactGenerator.medium.prepare()
        impactGenerator.light.prepare()
    }

    public func generate(_ notification: Haptics.Notification) {
        notificationGenerator.prepare()
        switch notification {
        case .success:
            notificationGenerator.notificationOccurred(.success)
        case .warning:
            notificationGenerator.notificationOccurred(.warning)
        case .error:
            notificationGenerator.notificationOccurred(.error)
        }
    }

    public func generate(_ impact: Haptics.Impact) {
        switch impact {
        case .light:
            impactGenerator.light.impactOccurred()
        case .medium:
            impactGenerator.medium.impactOccurred()
        case .heavy:
            impactGenerator.heavy.impactOccurred()
        }
    }
    
}

// MARK: - ImpactFeedbackGenerator

private struct ImpactFeedbackGenerator {
    var light = UIImpactFeedbackGenerator(style: .light)

    var medium = UIImpactFeedbackGenerator(style: .medium)

    var heavy = UIImpactFeedbackGenerator(style: .heavy)
}
