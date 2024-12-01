import Flutter
import UIKit
import CoreHaptics

@available(iOS 13.0, *)
public class TokeruHapticsPlugin: NSObject, FlutterPlugin {
  private var hapticEngine: CHHapticEngine?
  private var engineNeedsStart = true

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "tokeru_haptics", binaryMessenger: registrar.messenger())
    let instance = TokeruHapticsPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  override init() {
    super.init()
    createHapticEngine()

  }

  lazy var supportsHaptics: Bool = {
      CHHapticEngine.capabilitiesForHardware().supportsHaptics
  }()

  private func createHapticEngine() {
    do {
      hapticEngine = try CHHapticEngine()
      try hapticEngine?.start()

    } catch {
      print("Failed initialize Haptic Engine: \(error)")
    }
    hapticEngine?.resetHandler = {
      do {
        try self.hapticEngine?.start()
      } catch {
        fatalError("Failed to restart the engine: \(error)")
      }
    }

    // The stopped handler alerts engine stoppage.
    hapticEngine?.stoppedHandler = { reason in
        print("Stop Handler: The engine stopped for reason: \(reason.rawValue)")
        switch reason {
        case .audioSessionInterrupt:
            print("Audio session interrupt.")
        case .applicationSuspended:
            print("Application suspended.")
        case .idleTimeout:
            print("Idle timeout.")
        case .notifyWhenFinished:
            print("Finished.")
        case .systemError:
            print("System error.")
        case .engineDestroyed:
            print("Engine destroyed.")
        case .gameControllerDisconnect:
            print("Controller disconnected.")
        @unknown default:
            print("Unknown error")
        }

        // Indicate that the next time the app requires a haptic, the app must call engine.start().
        self.engineNeedsStart = true
    }

    // Start the haptic engine to prepare it for use.
    do {
        try hapticEngine?.start()

        // Indicate that the next time the app requires a haptic, the app doesn't need to call engine.start().
        engineNeedsStart = false
    } catch let error {
        print("The engine failed to start with error: \(error)")
    }
  }

  func startPlayer(_ player: CHHapticPatternPlayer) {
      do {
          try startHapticEngineIfNecessary()
          try player.start(atTime: CHHapticTimeImmediate)
      } catch let error {
          print("Error starting haptic player: \(error)")
      }
  }

  func stopPlayer(_ player: CHHapticPatternPlayer) {
      guard supportsHaptics else { return }

      do {
          try startHapticEngineIfNecessary()
          try player.stop(atTime: CHHapticTimeImmediate)
      } catch let error {
          print("Error stopping haptic player: \(error)")
      }
  }
  
  func startHapticEngineIfNecessary() throws {
      if engineNeedsStart {
          try hapticEngine?.start()
          engineNeedsStart = false
      }
  }

  func restartHapticEngine() {
      self.hapticEngine?.start { error in
          if let error = error {
              print("Haptic Engine Startup Error: \(error)")
              return
          }
          self.engineNeedsStart = false
      }
  }

  func stopHapticEngine() {
      self.hapticEngine?.stop { error in
          if let error = error {
              print("Haptic Engine Shutdown Error: \(error)")
              return
          }
          self.engineNeedsStart = true
      }
  }


  private func playHapticFeedback(sharpness: Float,intensity: Float) {
    let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: sharpness)
    let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: intensity)
    let hapticEvent = CHHapticEvent(eventType: .hapticTransient, parameters: [sharpness, intensity], relativeTime: 0)

    do {
      let pattern = try CHHapticPattern(events: [hapticEvent], parameters: [])
      guard let player = try hapticEngine?.makePlayer(with: pattern) else { return }
      startPlayer(player)
    } catch {
      print("Failed play Haptic Pattern: \(error)")
    }
  }

  private func notification(type: UINotificationFeedbackGenerator.FeedbackType, result: @escaping FlutterResult) {
    UINotificationFeedbackGenerator().notificationOccurred(type)
    result(nil)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
    case "vibrate":
      let arg = call.arguments as? [String: Any]
      let intensity = arg?["intensity"] as? NSNumber ?? 1.0
      let sharpness = arg?["sharpness"] as? NSNumber ?? 1.0
      playHapticFeedback(sharpness: Float(truncating: sharpness), intensity: Float(truncating: intensity))
    case "success":
      notification(type: .success, result: result)
    case "warning":
      notification(type: .warning, result: result)
    case "error":
      notification(type: .error, result: result)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}