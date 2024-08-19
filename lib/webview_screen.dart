import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  InAppWebViewController? webViewController;
  PullToRefreshController? refreshController;
  late var url;
  double progress = 0;
  var urlController = TextEditingController();
  final String initialUrl = 'https://ukayukaysupplier.com/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: InAppWebView(
              onWebViewCreated: (controller) => webViewController = controller,
              initialUrlRequest: URLRequest(
                url: WebUri(initialUrl), // Use Uri here
              ),
              onLoadStart: (controller, url) {
                setState(() {
                  this.url = url.toString();
                });
              },
              onLoadStop: (controller, url) {
                setState(() {
                  this.url = url.toString();
                });
              },
              onLoadError: (controller, url, code, message) {
                print("Error: $message");
              },
              onProgressChanged: (controller, progress) {
                setState(() {
                  this.progress = progress / 100;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
