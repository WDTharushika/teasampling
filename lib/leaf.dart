import 'package:flutter/material.dart';

void main() => runApp(const TeaSamplingApp());

class TeaSamplingApp extends StatelessWidget {
  const TeaSamplingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TeaSamplingScreen(),
    );
  }
}

class TeaSamplingScreen extends StatelessWidget {
  const TeaSamplingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Align(
          alignment: Alignment.centerLeft, // Align title to the left
          child: Text(
            'Leaf Sampling',
            style: TextStyle(
              fontFamily: 'Impact', // Change font to Impact
              fontSize: 24, // Set font size to 32
              color: Colors.black,
            ),
          ),
        ),
        elevation: 0, // Optional: removes the shadow for a flat look
      ),
      body: Stack(
        children: [
          // Background image with opacity
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
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Container with the tea leaf image
                Container(
                  width: double.infinity,
                  height: 220,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(250, 252, 254, 255),
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 4),
                        blurRadius: 8.0,
                      ),
                    ],
                    image: const DecorationImage(
                      image: AssetImage("images/tea_leaf.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Container with solid white color and text inside
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.white, // Solid white color
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Topic text
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
                        'Plants require 16 plant nutrients for completing their life cycle.',
                      ),
                      buildBulletPoint(
                        'A nutrient deficiency or excess show up in the foliage of the plant as distinct and characteristic symptoms.',
                      ),
                      buildBulletPoint(
                        'Chemical analysis of the foliage serves to confirm the visual observation and also gives a good indication of their nutritional status.',
                      ),
                      buildBulletPoint(
                        'Foliar analysis is recommended in instances where growth abnormalities are suspected to be due to nutritional problems.',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Container for "Time of Sampling"
                Container(
                  width: double.infinity,
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
                      // Header for the new section
                      const Text(
                        'Time of Sampling',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Impact',
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // New bullet points
                      buildBulletPoint(
                        'After a minimum period of 6 weeks following the last ground fertilizer application.',
                      ),
                      buildBulletPoint(
                        'When growth abnormalities are suspected to be due to nutritional problems.',
                      ),
                      buildBulletPoint(
                        'Avoid sampling during severe drought and heavy rains.',
                      ),
                      buildBulletPoint(
                        'Avoid sampling in the early part of first year and the latter part of final year of the pruning cycle.',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Container for "Technique of Sampling"
                Container(
                  width: double.infinity,
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
                      // Header for the new section
                      const Text(
                        'Technique of Sampling',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Impact',
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // New bullet points
                      buildBulletPoint(
                        'Obtain a leaf sample that is representative of the area.',
                      ),
                      buildBulletPoint(
                        'Avoid bushes growing in abnormal areas (close to road and drains, in bare patches).',
                      ),
                      buildBulletPoint(
                        'Collect only the first mature leaf at the plucking table (figure 1).',
                      ),
                      const SizedBox(height: 10),
                      // Container for the image
                      Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          image: const DecorationImage(
                            image: AssetImage(
                                'images/figure1.png'), // Path to the new image
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Container for "Number of Samples and Make a Composite Sample"
                Container(
                  width: double.infinity,
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
                      // Header for the new section
                      const Text(
                        'Number of Samples and Make a Composite Sample',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Impact',
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // New bullet points
                      buildBulletPoint(
                        'Collect about 100 leaves (first mature leaves) from each block of 2 hectare.',
                      ),
                      buildBulletPoint(
                        'Collect one leaf per bush.',
                      ),
                      buildBulletPoint(
                        'Pack a sample in polythene bags and label it giving details (information) of the sample.',
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
