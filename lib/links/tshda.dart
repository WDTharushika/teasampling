import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TshdaWebView extends StatefulWidget {
  const TshdaWebView({super.key});

  @override
  State<TshdaWebView> createState() => _TshdaWebViewState();
}

class _TshdaWebViewState extends State<TshdaWebView> {
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
      ..loadRequest(Uri.parse('https://tshda.lk/'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TSHDA'),
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
