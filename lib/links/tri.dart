import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TrislWebView extends StatefulWidget {
  const TrislWebView({super.key});

  @override
  State<TrislWebView> createState() => _TrislWebViewState();
}

class _TrislWebViewState extends State<TrislWebView> {
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
      ..loadRequest(Uri.parse('https://www.tri.lk/'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TRISL'),
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
