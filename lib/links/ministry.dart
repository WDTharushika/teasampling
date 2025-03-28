import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MinistryWebView extends StatefulWidget {
  const MinistryWebView({super.key});

  @override
  State<MinistryWebView> createState() => _MinistryWebViewState();
}

class _MinistryWebViewState extends State<MinistryWebView> {
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
      ..loadRequest(Uri.parse('https://plantation.gov.lk/'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ministry Of Plantation'),
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
