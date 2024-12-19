import 'package:flutter/material.dart';
import 'package:evezo/data/local/db_helper.dart';

class StallInfo extends StatefulWidget {
  const StallInfo({super.key});

  @override
  State<StallInfo> createState() => _StallInfoState();
}

class _StallInfoState extends State<StallInfo> {
  // Controllers to capture text input
  final TextEditingController _stallNameController = TextEditingController();
  final TextEditingController _stallNumberController = TextEditingController();
  final TextEditingController _stallTypeController = TextEditingController();

  // Function to save stall item to database
  Future<void> _saveStallItem() async {
    String stallName = _stallNameController.text;
    String stallNumber = _stallNumberController.text;
    String stallType = _stallTypeController.text;

    if (stallName.isNotEmpty &&
        stallNumber.isNotEmpty &&
        stallType.isNotEmpty) {
      bool success = await DBHelper.instance.addStall(
        stallName: stallName,
        stallNumber: stallNumber,
        stallType: stallType,
      );

      // Handle context-based UI updates safely
      _handleSaveResult(success);
    }
  }

  // Method to handle context-based UI updates
  void _handleSaveResult(bool success) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(success
            ? 'Stall item saved successfully!'
            : 'Failed to save stall item.'),
      ),
    );

    if (success) {
      // Clear fields after saving
      _stallNameController.clear();
      _stallNumberController.clear();
      _stallTypeController.clear();
    }
  }

  @override
  void dispose() {
    // Dispose of controllers when the widget is removed
    _stallNameController.dispose();
    _stallNumberController.dispose();
    _stallTypeController.dispose();
    super.dispose();
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
          child: Image.asset('assets/images/eve.png'),
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
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.only(
                left: 46, top: 60, right: 10), // Adjusted top padding
            child: const Text(
              'Enter Stall Info',
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
                    controller: _stallNameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFfcf6db),
                      hintText: 'Enter Stall Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _stallNumberController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFfcf6db),
                      hintText: 'Enter Stall Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _stallTypeController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFfcf6db),
                      hintText: 'Enter Stall Type',
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
                        onPressed: _saveStallItem,
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
