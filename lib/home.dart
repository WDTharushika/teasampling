import 'package:flutter/material.dart';
import 'package:tea_sampling/leaf.dart';
import 'package:tea_sampling/root.dart';
import 'package:tea_sampling/submission.dart';
import 'package:tea_sampling/soil.dart';
import 'package:tea_sampling/drawer/about_us.dart';
import 'package:tea_sampling/drawer/feedback.dart';
import 'package:tea_sampling/drawer/contact_us.dart';
import 'package:tea_sampling/notification.dart';
import 'package:tea_sampling/links/tri.dart'; // Import the TRISL WebView screen
import 'package:tea_sampling/links/ministry.dart'; // Import the Ministry WebView screen
import 'package:tea_sampling/links/tea_board.dart'; // Import the Tea Board WebView screen
import 'package:tea_sampling/links/tshda.dart'; // Import the TSHDA WebView screen
import 'package:tea_sampling/links/ctta.dart'; // Import the CTTA WebView screen
import 'package:tea_sampling/links/call.dart'; // Import the Call Center screen
import 'package:tea_sampling/drawer/location.dart'; // Import the Location screen
import 'package:tea_sampling/drawer/video.dart'; // Import the VideoTutorialScreen

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color.fromARGB(255, 182, 219, 180),
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        title: Row(
          children: [
            const Text(
              "Tea Sampling",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
            const Spacer(),
          ],
        ),
        toolbarHeight: 60,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PDFListScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              _scaffoldKey.currentState?.openEndDrawer();
            },
          ),
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.video_library),
              title: const Text('Video Tutorial'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const VideoTutorialScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.location_on),
              title: const Text('Our Location'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LocationWebView(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.contact_phone),
              title: const Text('Live Support'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ContactUsScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About Us'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AboutUsPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.feedback),
              title: const Text('Feedback'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FeedbackScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.5,
              child: Image.asset(
                'images/tea_signup.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TeaSamplingScreen(),
                        ),
                      );
                    },
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              'images/leaf_background.jpg',
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          const Center(
                            child: Text(
                              'Leaf',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RootScreen(),
                        ),
                      );
                    },
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              'images/root_background.jpg',
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.brown.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          const Center(
                            child: Text(
                              'Root',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SoilScreen(),
                        ),
                      );
                    },
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              'images/soil_background.jpg',
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.brown[300]!.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          const Center(
                            child: Text(
                              'Soil',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SubmissionScreen(),
                        ),
                      );
                    },
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              'images/submission_background.jpg',
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          const Center(
                            child: Text(
                              'Submission',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: const Text(
                      'Useful Links',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _buildUsefulLinkContainerWithImage('Call Center', 'images/Call.png', isCallCenter: true),
                      _buildUsefulLinkContainerWithImage('Ministry', 'images/Ministrery.png', isMinistry: true),
                      _buildUsefulLinkContainerWithImage('TRISL', 'images/TRI.png'),
                      _buildUsefulLinkContainerWithImage('Tea Board', 'images/TeaBoard.png', isTeaBoard: true),
                      _buildUsefulLinkContainerWithImage('TSHDA', 'images/TSHDA.png', isTSHDA: true),
                      _buildUsefulLinkContainerWithImage('CTTA', 'images/CTTA.png', isCTTA: true),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build each container for useful links with an image
  Widget _buildUsefulLinkContainerWithImage(String title, String imagePath,
      {bool isMinistry = false, bool isTeaBoard = false, bool isTSHDA = false, bool isCTTA = false, bool isCallCenter = false}) {
    return GestureDetector(
      onTap: () {
        if (isCallCenter) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CallCenterScreen(),
            ),
          );
        } else if (title == 'TRISL') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TrislWebView(),
            ),
          );
        } else if (title == 'Ministry') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MinistryWebView(),
            ),
          );
        } else if (title == 'Tea Board') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TeaBoardWebView(),
            ),
          );
        } else if (isTSHDA) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TshdaWebView(),
            ),
          );
        } else if (isCTTA) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CttaWebView(),
            ),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 113, 164, 104).withOpacity(0.5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Center(
                child: SizedBox(
                  width: (isMinistry || isTeaBoard) ? 130 : double.infinity,
                  height: (isMinistry || isTeaBoard) ? 150 : double.infinity,
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            Center(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
