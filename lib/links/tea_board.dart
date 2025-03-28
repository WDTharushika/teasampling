import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TeaBoardWebView extends StatefulWidget {
  const TeaBoardWebView({super.key});

  @override
  State<TeaBoardWebView> createState() => _TeaBoardWebViewState();
}

class _TeaBoardWebViewState extends State<TeaBoardWebView> {
  late WebViewController _webViewController;
  bool isLoading = true; // Track whether the page is still loading

  @override
  void initState() {
    super.initState();
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) {
            setState(() {
              isLoading = true; // Show loading indicator when page starts loading
            });
          },
          onPageFinished: (_) {
            setState(() {
              isLoading = false; // Hide loading indicator when page finishes loading
            });
          },
        ),
      )
      ..loadRequest(Uri.parse('https://www.srilankateaboard.lk/')); // Set the Tea Board URL
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tea Board'),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _webViewController),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(), // Display loading indicator
            ),
        ],
      ),
    );
  }
}
