import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';
import 'package:tea_sampling/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserLeaf extends StatefulWidget {
  final String? userId;
  final bool isEditing;
  final Map<String, dynamic>? userDetails;

  const UserLeaf({super.key, this.userId, this.isEditing = false, this.userDetails});

  @override
  State<UserLeaf> createState() => _UserLeafState();
}

class _UserLeafState extends State<UserLeaf> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();
  TextEditingController contactcontroller = TextEditingController();
  TextEditingController estatecontroller = TextEditingController();
  TextEditingController divisioncontroller = TextEditingController();
  TextEditingController fieldcontroller = TextEditingController();
  TextEditingController obsercontroller = TextEditingController();
  TextEditingController commentcontroller = TextEditingController();
  TextEditingController datecontroller = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryController = TextEditingController();
  TextEditingController cvvController = TextEditingController();

  String? currentUserId;
  DateTime? createdAt;
  int totalCost = 0;

  Map<String, int> sampleCosts = {
    "Carbon": 1320,
    "Nitrogen": 1310,
    "Phosphorus": 2500,
    "Potassium": 1820,
    "Sodium": 1820,
    "Magnesium": 1920,
    "Calcium": 1480,
    "Lead": 2130,
    "Copper": 1950,
    "Iron": 1950,
    "Zinc": 1950,
    "Manganese": 1950,
    "Aluminium": 2140,
        
  };

  Map<String, int> selectedSamples = {}; // Stores selected sample types and their quantities

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    createdAt = widget.isEditing ? createdAt : DateTime.now();

    if (widget.isEditing && widget.userDetails != null) {
      namecontroller.text = widget.userDetails!["Name of the owner"];
      addresscontroller.text = widget.userDetails!["Address"];
      contactcontroller.text = widget.userDetails!["Contact number"];
      estatecontroller.text = widget.userDetails!["Name of the estate"];
      divisioncontroller.text = widget.userDetails!["Division"];
      fieldcontroller.text = widget.userDetails!["Field number and extent(In hectares)"];
      obsercontroller.text = widget.userDetails!["Special observations"];
      commentcontroller.text = widget.userDetails!["Any comments"];
      datecontroller.text = widget.userDetails!["Date of sampling"];
      createdAt = (widget.userDetails!["createdAt"] as Timestamp?)?.toDate();
    }
  }

  getCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      currentUserId = user?.uid;
    });
  }

  calculateTotalCost() {
    int cost = 0;
    selectedSamples.forEach((sample, quantity) {
      cost += (sampleCosts[sample] ?? 0) * quantity;
    });
    setState(() {
      totalCost = cost;
    });
  }

  void showMockPaymentScreen() {
    if (areFieldsFilled()) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              top: 20,
              left: 20,
              right: 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: cardNumberController,
                  decoration: InputDecoration(labelText: "Card Number"),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: expiryController,
                  decoration: InputDecoration(labelText: "Expiry Date (MM/YY)"),
                  keyboardType: TextInputType.datetime,
                ),
                TextField(
                  controller: cvvController,
                  decoration: InputDecoration(labelText: "CVV"),
                  keyboardType: TextInputType.number,
                  obscureText: true,
                ),
                TextField(
                  controller: amountController,
                  decoration: InputDecoration(labelText: "Enter Total Amount"),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    confirmPayment();
                    Navigator.pop(context);
                  },
                  child: Text("Confirm Payment"),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill in all required fields.")),
      );
    }
  }

  bool areFieldsFilled() {
    return namecontroller.text.isNotEmpty &&
        addresscontroller.text.isNotEmpty &&
        contactcontroller.text.isNotEmpty &&
        estatecontroller.text.isNotEmpty &&
        divisioncontroller.text.isNotEmpty &&
        fieldcontroller.text.isNotEmpty &&
        obsercontroller.text.isNotEmpty &&
        commentcontroller.text.isNotEmpty &&
        datecontroller.text.isNotEmpty &&
        selectedSamples.isNotEmpty; // Ensure at least one sample is selected
  }

  confirmPayment() async {
    int enteredAmount = int.tryParse(amountController.text) ?? 0;

    if (enteredAmount != totalCost) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Incorrect amount entered! Expected: Rs. $totalCost")),
      );
    } else {
      // Generate a random ID for new entries
      String id = widget.isEditing ? widget.userId! : randomAlphaNumeric(10);

      Map<String, dynamic> userInfoMap = {
        "id": id,
        "Name of the owner": namecontroller.text,
        "Address": addresscontroller.text,
        "Contact number": contactcontroller.text,
        "Name of the estate": estatecontroller.text,
        "Division": divisioncontroller.text,
        "Field number and extent(In hectares)": fieldcontroller.text,
        "Special observations": obsercontroller.text,
        "Any comments": commentcontroller.text,
        "Date of sampling": datecontroller.text,
        "uid": currentUserId,
        "createdAt": createdAt,
        "Samples": selectedSamples, // Add selected samples and their quantities
      };

      if (widget.isEditing) {
        await DatabaseMethods().updateUserDetails(id, userInfoMap);
      } else {
        await DatabaseMethods().addUserDetails(userInfoMap, id);
      }

      // Navigate to the Payment Confirmation screen with user ID and total cost
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentConfirmationScreen(userId: id, totalCost: totalCost),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Text(
              "Detail Form",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 20, top: 30, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField("Name of the owner", namecontroller),
              _buildTextField("Address", addresscontroller),
              _buildTextField("Contact number", contactcontroller),
              _buildTextField("Name of the estate", estatecontroller),
              _buildTextField("Division", divisioncontroller),
              _buildTextField("Field number and extent(In hectares)", fieldcontroller),
              _buildTextField("Special observations", obsercontroller),
              _buildTextField("Any comments", commentcontroller),
              _buildTextField("Date of sampling", datecontroller),
              const SizedBox(height: 20),

              if (createdAt != null) // Display the formatted creation date
                Text(
                  "Created on: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(createdAt!)}",
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),

              const SizedBox(height: 20),

              Text("Select Sample Types and Quantities"),
              ...sampleCosts.keys.map((sample) {
                return CheckboxListTile(
                  title: Text(sample),
                  value: selectedSamples.containsKey(sample),
                  onChanged: (isSelected) {
                    setState(() {
                      if (isSelected == true) {
                        selectedSamples[sample] = 1; // Default quantity is 1
                      } else {
                        selectedSamples.remove(sample);
                      }
                      calculateTotalCost();
                    });
                  },
                  subtitle: selectedSamples.containsKey(sample)
                      ? Row(
                          children: [
                            Text("Quantity: "),
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                setState(() {
                                  if (selectedSamples[sample]! > 1) {
                                    selectedSamples[sample] =
                                        selectedSamples[sample]! - 1;
                                    calculateTotalCost();
                                  }
                                });
                              },
                            ),
                            Text(selectedSamples[sample].toString()),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                setState(() {
                                  selectedSamples[sample] =
                                      selectedSamples[sample]! + 1;
                                  calculateTotalCost();
                                });
                              },
                            ),
                          ],
                        )
                      : null,
                );
              }).toList(),

              Text(
                "Total Cost: Rs. $totalCost",
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),

              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (totalCost > 0) {
                      showMockPaymentScreen();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please select at least one sample.")),
                      );
                    }
                  },
                  child: Text(
                    "Proceed to Payment",
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String labelText, TextEditingController controller, {Function(String)? onChanged}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: const TextStyle(color: Colors.black, fontSize: 25),
        ),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            decoration: const InputDecoration(border: InputBorder.none),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

// Confirmation screen to display after payment and data submission
class PaymentConfirmationScreen extends StatelessWidget {
  final String userId;
  final int totalCost;

  const PaymentConfirmationScreen({Key? key, required this.userId, required this.totalCost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Confirmation"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "User ID: $userId",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "Total Payable: Rs. $totalCost",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Text(
              "You can change the details within 3 days. After that, any changes to information are not applicable.",
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            const SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Back to Home"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
