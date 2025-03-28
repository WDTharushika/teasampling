import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart'; // Firebase Storage
import 'package:flutter_pdfview/flutter_pdfview.dart'; // PDF viewer package
import 'package:path_provider/path_provider.dart'; // For accessing the file system
import 'dart:io'; // For file operations
import 'package:http/http.dart' as http; // For downloading the PDF

class PDFListScreen extends StatefulWidget {
  const PDFListScreen({Key? key}) : super(key: key);

  @override
  _PDFListScreenState createState() => _PDFListScreenState();
}

class _PDFListScreenState extends State<PDFListScreen> {
  List<Map<String, dynamic>> _pdfList = [];

  @override
  void initState() {
    super.initState();
    _fetchPDFs();
  }

  // Fetch the list of PDFs from Firebase Storage
  Future<void> _fetchPDFs() async {
    FirebaseStorage storage = FirebaseStorage.instance;

    try {
      final ListResult result = await storage.ref().listAll(); // List all files in the root directory
      List<Map<String, dynamic>> files = [];

      for (var ref in result.items) {
        final String downloadURL = await ref.getDownloadURL();
        files.add({
          "name": ref.name,
          "url": downloadURL,
        });
      }

      setState(() {
        _pdfList = files;
      });
    } catch (e) {
      print("Error fetching PDFs: $e");
    }
  }

  // Download the PDF file from Firebase Storage and open it
  Future<void> _downloadAndOpenPDF(String url, String fileName) async {
    try {
      // Get the directory to store the downloaded file
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$fileName");

      // Check if the file already exists
      if (!await file.exists()) {
        // Download the PDF from the provided URL
        var response = await http.get(Uri.parse(url));

        // Save the PDF to the local file system
        file = await file.writeAsBytes(response.bodyBytes);
      }

      // Open the PDF in the PDF Viewer
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PDFViewerScreen(pdfFilePath: file.path),
        ),
      );
    } catch (e) {
      print("Error opening PDF: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Notifications'),
        backgroundColor: Colors.green,
      ),
      body: _pdfList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _pdfList.length,
              itemBuilder: (context, index) {
                final pdf = _pdfList[index];
                return ListTile(
                  title: Text(pdf['name']),
                  trailing: IconButton(
                    icon: const Icon(Icons.picture_as_pdf),
                    onPressed: () => _downloadAndOpenPDF(pdf['url'], pdf['name']),
                  ),
                );
              },
            ),
    );
  }
}

// Screen to display the PDF using flutter_pdfview
class PDFViewerScreen extends StatelessWidget {
  final String pdfFilePath;

  const PDFViewerScreen({Key? key, required this.pdfFilePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Viewer'),
        backgroundColor: Colors.green,
      ),
      body: PDFView(
        filePath: pdfFilePath, // Load the PDF from the local file path
        enableSwipe: true,
        swipeHorizontal: false,
        autoSpacing: true,
        pageFling: true,
        onRender: (pages) {
          print("Rendered $pages pages");
        },
        onError: (error) {
          print(error.toString());
        },
        onPageError: (page, error) {
          print('$page: ${error.toString()}');
        },
      ),
    );
  }
}
