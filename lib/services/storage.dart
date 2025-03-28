import 'package:firebase_storage/firebase_storage.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Method to list all files in a specific path
  Future<List<String>> listAllFiles(String path) async {
    List<String> fileUrls = [];
    try {
      // Get reference to the folder in Firebase Storage
      final Reference storageRef = _storage.ref().child(path);

      // List all the files in that folder
      final ListResult result = await storageRef.listAll();

      // Loop through each file and get the download URL
      for (var ref in result.items) {
        final String fileUrl = await ref.getDownloadURL();
        fileUrls.add(fileUrl);
      }
    } catch (e) {
      print(e);
    }
    return fileUrls; // Return list of URLs
  }
}