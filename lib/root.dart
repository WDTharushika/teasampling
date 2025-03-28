import 'package:flutter/material.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: const Align(
          alignment: Alignment.centerLeft, // Align title to the left
          child: Text(
            'Root Sampling',
            style: TextStyle(
              fontFamily: 'Impact', // Change font to Impact
              fontSize: 24, // Set font size to 24
              color: Colors.black,
            ),
          ),
        ),
        centerTitle: false, // Disable center alignment
        elevation: 0, // Optional: removes the shadow for a flat look
      ),
      body: Stack(
        children: [
          // Background image that covers the entire screen
          Positioned.fill(
            child: Image.asset(
              'images/tea_signup.jpg', // Ensure this path is correct
              fit: BoxFit.cover,
            ),
          ),
          // Semi-transparent overlay to dim the background image
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.3),
            ),
          ),
          // Scrollable content on top of the background image
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20), // Space from the top
                // Container with the same dimensions as the tea_leaf.jpg image
                Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 16.0),
                  height: 220, // Same height as the tea_leaf.jpg image
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 4),
                        blurRadius: 8.0,
                      ),
                    ],
                    image: const DecorationImage(
                      image: AssetImage("images/root.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // New container for text and image
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.white, // Solid white color
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 4),
                        blurRadius: 8.0,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header text
                      const Text(
                        'Introduction',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Impact',
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Custom bullet points
                      buildBulletPoint(
                        'Plant parasitic nematodes attack the root system causing damages in all stages of tea.',
                      ),
                      const SizedBox(height: 20),
                      // Image below the text
                      Center(
                        child: Image.asset(
                          'images/figure2.png', // Path to your image
                          width: 400, // Set appropriate width
                          height: 100, // Set appropriate height
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Additional bullet point text
                      buildBulletPoint(
                        'Symptoms caused by nematodes are slow decline in growth, yellowing of leaves, premature flowering & fruiting and stunted growth.',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBulletPoint(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Adjusted size and alignment for the bullet point
        Container(
          margin:
              const EdgeInsets.only(top: 4), // Adjust for vertical alignment
          child: const Icon(
            Icons.circle,
            size: 12, // Decreased size for the bullet
            color: Colors.black,
          ),
        ),
        const SizedBox(width: 8), // Adjusted for better spacing
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
