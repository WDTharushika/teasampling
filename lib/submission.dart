import 'package:flutter/material.dart';
import 'package:tea_sampling/submission/leaf_submission.dart';
import 'package:tea_sampling/submission/root_submission.dart';
import 'package:tea_sampling/submission/soil_submission.dart';

class SubmissionScreen extends StatelessWidget {
  const SubmissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Submission",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenSize.width * 0.05),
          child: Column(
            children: [
              buildSubmissionContainer(
                screenSize,
                "Leaf Submission",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LeafSubmission(),
                    ),
                  );
                },
              ),
              SizedBox(height: screenSize.height * 0.03),
              buildSubmissionContainer(
                screenSize,
                "Root Submission",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RootSubmission(),
                    ),
                  );
                },
              ),
              SizedBox(height: screenSize.height * 0.03),
              buildSubmissionContainer(
                screenSize,
                "Soil Submission",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SoilSubmission(),
                    ),
                  );
                },
              ),
              SizedBox(height: screenSize.height * 0.03),
              buildInformationContainer(screenSize),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSubmissionContainer(Size screenSize, String label, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(screenSize.width * 0.05),
        decoration: BoxDecoration(
          color: Colors.lightGreen[100],
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.green,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(Icons.eco, color: Colors.green),
            const SizedBox(width: 20),
            Text(
              label,
              style: TextStyle(
                fontSize: screenSize.width * 0.05,
                fontWeight: FontWeight.bold,
                color: Colors.green[900],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInformationContainer(Size screenSize) {
    return Container(
      padding: EdgeInsets.all(screenSize.width * 0.05),
      decoration: BoxDecoration(
        color: Colors.blueGrey[50],
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.blueGrey,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildInfoText(
            icon: Icons.info,
            text: "Must include the correct information.",
            iconColor: Colors.blue,
          ),
          const SizedBox(height: 8),
          buildInfoText(
            icon: Icons.tag,
            text:
                "When the sample is tagged, you should clearly tag the ID number provided by the application in each sample.",
            iconColor: Colors.green,
          ),
          const SizedBox(height: 8),
          buildInfoText(
            icon: Icons.local_shipping,
            text:
                "We currently don't have delivery options; please use a courier service to send the sample to the our location (mentioned in the menu bar location option).",
            iconColor: Colors.orange,
          ),
          const SizedBox(height: 8),
          buildInfoText(
            icon: Icons.timer,
            text: "Your report will be delivered to you by the application within 7 days.",
            iconColor: Colors.purple,
          ),
          const SizedBox(height: 8),
          buildInfoText(
            icon: Icons.contact_phone,
            text: "For further instructions, please contact us.",
            iconColor: Colors.red,
          ),
        ],
      ),
    );
  }

  Widget buildInfoText({required IconData icon, required String text, required Color iconColor}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: iconColor, size: 24),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87),
          ),
        ),
      ],
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: SubmissionScreen(),
  ));
}
