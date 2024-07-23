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
  @Environment(AppDelegate.self) var appDelegate
  var route: String
  
  func makeUIViewController(context: Context) -> some UIViewController {
    let flutterViewController = FlutterViewController(
      engine: appDelegate.flutterEngine,
      nibName: nil,
      bundle: nil)
  
    // ルートを指定して Flutter の画面をに遷移する。
    let channel = FlutterMethodChannel(
      name: "com.kosukesaigusa.iOSApp/navigation",
      binaryMessenger: flutterViewController.binaryMessenger)
    channel.invokeMethod("navigateTo", arguments: route)
    
    return flutterViewController
  }
  
  func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}

struct ContentView: View {
  var body: some View {
    NavigationStack {
      NavigationLink("Flutter Home") {
        FlutterViewControllerRepresentable(route: "/")
      }
      NavigationLink("Flutter Profile") {
        FlutterViewControllerRepresentable(route: "/profile")
      }
      NavigationLink("Flutter Settings") {
        FlutterViewControllerRepresentable(route: "/settings")
      }
    }
  }
}
