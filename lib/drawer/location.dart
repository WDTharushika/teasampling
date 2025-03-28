import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LocationWebView extends StatefulWidget {
  const LocationWebView({super.key});

  @override
  State<LocationWebView> createState() => _LocationWebViewState();
}

class _LocationWebViewState extends State<LocationWebView> {
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
      ..loadRequest(Uri.parse('https://maps.app.goo.gl/MJRWSBGAcDvvMhgn6')); // Replace with your Google Maps link
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Our Location'),
        backgroundColor: Colors.green,
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
