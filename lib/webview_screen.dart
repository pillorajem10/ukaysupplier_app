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
  final String initialUrl = 'https://ukayukaysupplier.com/login/';

  @override
  void initState() {
    super.initState();

    // Initialize the PullToRefreshController
    refreshController = PullToRefreshController(
      onRefresh: () async {
        // Trigger the web view to reload the current URL
        if (webViewController != null) {
          await webViewController!.reload();
        }
      },
      options: PullToRefreshOptions(
        color: Colors.blue, // Customize the refresh indicator color
      ),
    );
  }

  Future<bool> _onWillPop() async {
    if (webViewController != null) {
      bool canGoBack = await webViewController!.canGoBack();
      if (canGoBack) {
        webViewController!.goBack();
        return Future.value(false); // Prevent the default back action
      }
    }
    return Future.value(true); // Allow the default back action
  }

  @override
  void dispose() {
    refreshController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: InAppWebView(
                pullToRefreshController: refreshController,
                onWebViewCreated: (controller) => webViewController = controller,
                initialUrlRequest: URLRequest(
                  url: WebUri(initialUrl), // Use Uri here
                ),
                onLoadStart: (controller, url) {
                  setState(() {
                    this.url = url.toString();
                  });
                },
                onLoadStop: (controller, url) async {
                  setState(() {
                    this.url = url.toString();
                  });

                  // Stop the pull-to-refresh indicator when the page finishes loading
                  if (refreshController != null) {
                    refreshController!.endRefreshing();
                  }
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
      ),
    );
  }
}
