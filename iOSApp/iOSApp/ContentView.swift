//import SwiftUI
//import Flutter
//
//struct FlutterViewControllerRepresentable: UIViewControllerRepresentable {
//  // Flutter dependencies are passed in through the view environment.
//  @Environment(FlutterDependencies.self) var flutterDependencies
//  
//  func makeUIViewController(context: Context) -> some UIViewController {
//    return FlutterViewController(
//      engine: flutterDependencies.flutterEngine,
//      nibName: nil,
//      bundle: nil)
//  }
//  
//  func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
//}
//
//struct ContentView: View {
//
//  var body: some View {
//    NavigationStack {
//      NavigationLink("My Flutter Feature") {
//        FlutterViewControllerRepresentable()
//      }
//    }
//  }
//}

import SwiftUI
import Flutter

struct FlutterViewControllerRepresentable: UIViewControllerRepresentable {
  // Access the AppDelegate through the view environment.
  @Environment(AppDelegate.self) var appDelegate
  
  func makeUIViewController(context: Context) -> some UIViewController {
    return FlutterViewController(
      engine: appDelegate.flutterEngine,
      nibName: nil,
      bundle: nil)
  }
  
  func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}

struct ContentView: View {

  var body: some View {
    NavigationStack {
      NavigationLink("My Flutter Feature") {
        FlutterViewControllerRepresentable()
      }
    }
  }
}
