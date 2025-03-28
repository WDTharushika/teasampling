import 'package:flutter/material.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  String selectedEmoji = '';
  final TextEditingController feedbackController = TextEditingController();
  bool isEmojiSelected = false;

  @override
  void dispose() {
    feedbackController.dispose();
    super.dispose();
  }

  void submitFeedback() {
    if (feedbackController.text.isNotEmpty && selectedEmoji.isNotEmpty) {
      // Handle feedback submission logic
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Thank you for your feedback!'),
          backgroundColor: Colors.green,
        ),
      );
      feedbackController.clear();
      setState(() {
        selectedEmoji = '';
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select an emoji and enter your feedback.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget buildEmoji(String emoji) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedEmoji = emoji;
          isEmojiSelected = true;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color:
              selectedEmoji == emoji ? Colors.green[200] : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          emoji,
          style: const TextStyle(fontSize: 30),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'We value your feedback!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildEmoji('😊'),
                  buildEmoji('😐'),
                  buildEmoji('😢'),
                  buildEmoji('😠'),
                  buildEmoji('😍'),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                controller: feedbackController,
                maxLines: 6,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Enter your feedback here',
                  prefixIcon: selectedEmoji.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            selectedEmoji,
                            style: const TextStyle(fontSize: 24),
                          ),
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: submitFeedback,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
