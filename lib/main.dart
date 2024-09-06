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
  final status = await [
    Permission.camera,
    Permission.microphone,
    Permission.photos, // For media access
    Permission.storage, // For file storage access
  ].request();

  // Check if permissions are granted
  if (status[Permission.storage] != PermissionStatus.granted) {
    // Handle case when storage permission is not granted
    print('Storage permission not granted');
    if (status[Permission.storage] == PermissionStatus.permanentlyDenied) {
      // Open app settings if the permission is permanently denied
      await openAppSettings();
    }
  }
  // Handle other permissions similarly if needed
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
