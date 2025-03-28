import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart'; // Import intl for date formatting
import 'package:tea_sampling/services/database.dart';
import 'package:tea_sampling/submission/user_root.dart';

class RootSubmission extends StatefulWidget {
  const RootSubmission({super.key});

  @override
  State<RootSubmission> createState() => RootSubmissionState();
}

class RootSubmissionState extends State<RootSubmission> {
  Stream? userStream;
  String? userId;

  @override
  void initState() {
    super.initState();
    getUserDetailsStream();
  }

  getUserDetailsStream() async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      userId = currentUser.uid;
      userStream = await DatabaseMethods().getUserDetails(userId!, collection: 'Root detail form');
      setState(() {});
    }
  }

  Widget allUserDetails() {
    return StreamBuilder(
      stream: userStream,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (!snapshot.hasData || snapshot.data.docs.isEmpty) {
          return const Center(
            child: Text(
              "No entered data",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
            ),
          );
        } else {
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot ds = snapshot.data.docs[index];
              Map<String, dynamic> userDetails = ds.data() as Map<String, dynamic>;

              // Format createdOn date for subtitle display
              String createdOnFormatted = "No Date";
              if (userDetails["createdAt"] != null) {
                DateTime createdAt = (userDetails["createdAt"] as Timestamp).toDate();
                createdOnFormatted = DateFormat('dd/MM/yyyy HH:mm:ss').format(createdAt); // Adjust format as in user_leaf.dart
              }

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserRootDetailScreen(userDetails: userDetails),
                    ),
                  );
                },
                child: ListTile(
                  title: Text(userDetails["id"] ?? "No ID"), // Display ID as title
                  subtitle: Text("Created On: $createdOnFormatted"), // Show Created On as subtitle
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserRoot(
                                userId: userDetails["id"],
                                isEditing: true,
                                userDetails: userDetails,
                              ),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
                          await DatabaseMethods().deleteUserDetails(userDetails["id"], collection: 'Root detail form');
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const UserRoot()));
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text(
          "Tea Sampling",
          style: TextStyle(
            color: Colors.blue,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            Expanded(child: allUserDetails()),
          ],
        ),
      ),
    );
  }
}

class UserRootDetailScreen extends StatelessWidget {
  final Map<String, dynamic> userDetails;

  const UserRootDetailScreen({Key? key, required this.userDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Parse and format the createdAt field to match the format in user_leaf.dart
    String createdOnFormatted = "No Date";
    if (userDetails["createdAt"] != null) {
      DateTime createdAt = (userDetails["createdAt"] as Timestamp).toDate(); // Assuming Timestamp format from Firestore
      createdOnFormatted = DateFormat('dd/MM/yyyy HH:mm:ss').format(createdAt); // Replace with exact format from user_leaf.dart
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("User Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name of the Owner: ${userDetails["Name of the owner"] ?? "No Name"}"),
            Text("Address: ${userDetails["Address"] ?? "No Address"}"),
            Text("Contact Number: ${userDetails["Contact number"] ?? "No Contact Number"}"),
            Text("Name of the Estate: ${userDetails["Name of the estate"] ?? "No Estate"}"),
            Text("Division: ${userDetails["Division"] ?? "No Division"}"),
            Text("Created On: $createdOnFormatted"), // Display formatted date and time as Created On
            Text("ID: ${userDetails["id"] ?? "No ID"}"),
          ],
        ),
      ),
    );
  }
}
