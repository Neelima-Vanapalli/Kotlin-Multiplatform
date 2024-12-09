import SwiftUI
import LoginScreen
import UI

@main
struct iOSApp: App {
	var body: some Scene {
		WindowGroup {
			LoginScreenWrapper()
		}
	}
}

struct LoginScreenWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        return LoginScreen() // Your custom UIViewController
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}