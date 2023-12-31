import UIKit

// MARK: - Haptics

public struct Haptics {
    private static var instance = Haptics()

    private var notificationGenerator: UINotificationFeedbackGenerator {
        UINotificationFeedbackGenerator()
    }
    private var selectionGenerator: UISelectionFeedbackGenerator {
        UISelectionFeedbackGenerator()
    }
    private var impactGenerator: ImpactFeedbackGenerator = .init()

    public enum Feedback {
        case notifitcation(Notification)
        case impact(Impact)
        case selection
    }

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

    public static func prepare(_ feedback: Haptics.Feedback) {
        switch feedback {
        case .notifitcation(_):
            Haptics.instance.notificationGenerator.prepare()
        case .impact(let impact):
            switch impact {
            case .light:
                Haptics.instance.impactGenerator.light.prepare()
            case .medium:
                Haptics.instance.impactGenerator.medium.prepare()
            case .heavy:
                Haptics.instance.impactGenerator.heavy.prepare()
            }
        case .selection:
            Haptics.instance.selectionGenerator.prepare()
        }
    }

    public static func generate(_ feedback: Haptics.Feedback) {
        switch feedback {
        case let .notifitcation(notification):
            generate(notification)
        case let .impact(impact):
            generate(impact)
        case .selection:
            generateSelection()
        }
    }

    private static func generateSelection() {
        Haptics.instance.selectionGenerator.prepare()
        Haptics.instance.selectionGenerator.selectionChanged()
    }

    private static func generate(_ notification: Haptics.Notification) {
        Haptics.instance.notificationGenerator.prepare()
        switch notification {
        case .success:
            Haptics.instance.notificationGenerator.notificationOccurred(.success)
        case .warning:
            Haptics.instance.notificationGenerator.notificationOccurred(.warning)
        case .error:
            Haptics.instance.notificationGenerator.notificationOccurred(.error)
        }
    }

    private static func generate(_ impact: Haptics.Impact) {
        switch impact {
        case .light:
            Haptics.instance.impactGenerator.light.prepare()
            Haptics.instance.impactGenerator.light.impactOccurred()
        case .medium:
            Haptics.instance.impactGenerator.medium.prepare()
            Haptics.instance.impactGenerator.medium.impactOccurred()
        case .heavy:
            Haptics.instance.impactGenerator.heavy.prepare()
            Haptics.instance.impactGenerator.heavy.impactOccurred()
        }
    }
}

// MARK: - ImpactFeedbackGenerator

private struct ImpactFeedbackGenerator {
    var light: UIImpactFeedbackGenerator {
        UIImpactFeedbackGenerator(style: .light)
    }

    var medium: UIImpactFeedbackGenerator {
        UIImpactFeedbackGenerator(style: .medium)
    }

    var heavy: UIImpactFeedbackGenerator {
        UIImpactFeedbackGenerator(style: .heavy)
    }
}
