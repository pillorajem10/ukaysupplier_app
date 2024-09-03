import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewPage extends StatefulWidget {
  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  InAppWebViewController? _webViewController;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Check if the WebView can go back
        if (await _webViewController?.canGoBack() ?? false) {
          _webViewController?.goBack();
          return false; // Prevent the app from exiting
        }
        return true; // Exit the app if WebView cannot go back
      },
      child: Scaffold(
        body: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: _handleRefresh,
          child: Column(
            children: <Widget>[
              Expanded(
                child: InAppWebView(
                  initialUrlRequest: URLRequest(url: WebUri("https://ukayukaysupplier.com/login/")),
                  initialOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions(
                      // Add any necessary options here
                    ),
                  ),
                  onWebViewCreated: (controller) {
                    _webViewController = controller;
                  },
                  androidOnPermissionRequest: (controller, origin, resources) async {
                    return PermissionRequestResponse(
                      resources: resources,
                      action: PermissionRequestResponseAction.GRANT,
                    );
                  },
                  onLoadStop: (controller, url) {
                    // This can be used to update UI or stop any loading indicators
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleRefresh() async {
    if (_webViewController != null) {
      await _webViewController!.reload();
    }
  }
}
