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
    
    public static func prepare() {
        Haptics.instance.notificationGenerator.prepare()
        Haptics.instance.impactGenerator.heavy.prepare()
        Haptics.instance.impactGenerator.medium.prepare()
        Haptics.instance.impactGenerator.light.prepare()
    }

    public static func generate(_ notification: Haptics.Notification) {
        switch notification {
        case .success:
            Haptics.instance.notificationGenerator.notificationOccurred(.success)
        case .warning:
            Haptics.instance.notificationGenerator.notificationOccurred(.warning)
        case .error:
            Haptics.instance.notificationGenerator.notificationOccurred(.error)
        }
    }

    public static func generate(_ impact: Haptics.Impact) {
        switch impact {
        case .light:
            Haptics.instance.impactGenerator.light.impactOccurred()
        case .medium:
            Haptics.instance.impactGenerator.medium.impactOccurred()
        case .heavy:
            Haptics.instance.impactGenerator.heavy.impactOccurred()
        }
    }
    
}

// MARK: - ImpactFeedbackGenerator

private struct ImpactFeedbackGenerator {
    var light = UIImpactFeedbackGenerator(style: .light)

    var medium = UIImpactFeedbackGenerator(style: .medium)

    var heavy = UIImpactFeedbackGenerator(style: .heavy)
}
