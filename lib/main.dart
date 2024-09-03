import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'webview.dart'; // Import your WebViewPage here

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Request necessary permissions
  await _requestPermissions();

  runApp(MyApp());
}

Future<void> _requestPermissions() async {
  // Request permissions
  await [
    Permission.camera,
    Permission.microphone,
    Permission.photos, // Includes read/write access to external storage
  ].request();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,  // Disable the debug banner here
      home: WebViewPage(), // Your WebView page
    );
  }
}
