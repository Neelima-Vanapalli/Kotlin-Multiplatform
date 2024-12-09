import SwiftUI

@main
struct iOSApp: App {
	var body: some Scene {
		WindowGroup {
			ViewControllerWrapper()
		}
	}
}

struct ViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        return ViewController() // Your custom UIViewController
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}