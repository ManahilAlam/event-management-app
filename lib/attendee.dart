import 'package:flutter/material.dart';
import 'package:evezo/data/local/db_helper.dart';

class AttendeeInfo extends StatefulWidget {
  const AttendeeInfo({super.key}); // Simplified using `super.key`

  @override
  State<AttendeeInfo> createState() => _AttendeeInfoState();
}

class _AttendeeInfoState extends State<AttendeeInfo> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dietaryRestrictionsController =
  TextEditingController();
  final TextEditingController accessibilityRequirementsController =
  TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    dietaryRestrictionsController.dispose();
    accessibilityRequirementsController.dispose();
    super.dispose();
  }

  Future<void> _saveAttendeeInfo() async {
    final bool success = await DBHelper.instance.addAttendee({
      DBHelper.instance.columnAttendeeName: nameController.text,
      DBHelper.instance.columnAttendeePhone: phoneController.text,
      DBHelper.instance.columnAttendeeEmail: emailController.text,
      DBHelper.instance.columnAttendeeDietaryRestrictions:
      dietaryRestrictionsController.text,
      DBHelper.instance.columnAttendeeAccessibilityRequirements:
      accessibilityRequirementsController.text,
    });

    if (!mounted) {
      return; // Return early if the widget is no longer in the tree.
    }

    final String message =
    success ? 'Attendee Info Saved' : 'Error saving Attendee Info';
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFCED4BE),
      appBar: AppBar(
        backgroundColor: const Color(0xFFCED4BE),
        title: Container(
          alignment: Alignment.center,
          height: 50,
          width: 50,
          child: Image.asset('assets/images/eve.jpeg'),
        ),
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 20, top: 20, right: 10),
            child: const Text(
              '. Organize Your Event .',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 46, top: 60, right: 10),
            child: const Text(
              'Enter Attendee Info',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.13,
                right: 35,
                left: 35,
              ),
              child: Column(
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFfcf6db),
                      hintText: 'Enter Attendee Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFfcf6db),
                      hintText: 'Enter Attendee Phone Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFfcf6db),
                      hintText: 'Enter Attendee Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: dietaryRestrictionsController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFfcf6db),
                      hintText: 'Enter Dietary Restrictions',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: accessibilityRequirementsController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFfcf6db),
                      hintText: 'Enter Accessibility Requirements',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3f6267),
                        ),
                        onPressed: _saveAttendeeInfo,
                        child: const Text(
                          'Done',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
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
}
