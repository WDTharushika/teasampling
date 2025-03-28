import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CallCenterScreen extends StatelessWidget {
  final String hotline = '+94715795099';
  final List<String> contactNumbers = ['+94112345678', '+94112345679', '+94112345680'];
  final String email = 'support@example.com';

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  Future<void> _sendEmail(String emailAddress) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: emailAddress,
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch email $emailAddress';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hotline',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ListTile(
              leading: Icon(Icons.phone, color: Colors.blue),
              title: Text(hotline),
              onTap: () => _makePhoneCall(hotline),
            ),
            Divider(),
            Text(
              'Other Contact Numbers',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Column(
              children: contactNumbers.map((number) {
                return ListTile(
                  leading: Icon(Icons.phone, color: Colors.blue),
                  title: Text(number),
                  onTap: () => _makePhoneCall(number),
                );
              }).toList(),
            ),
            Divider(),
            Text(
              'Email',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ListTile(
              leading: Icon(Icons.email, color: Colors.blue),
              title: Text(email),
              onTap: () => _sendEmail(email),
            ),
          ],
        ),
      ),
    );
  }
}
