import 'package:flutter/material.dart';

//import 'attendee.dart';
//import 'items.dart';
//import 'menu.dart';
//import 'music.dart';
class EveOrg extends StatefulWidget {
  const EveOrg({super.key});

  @override
  State<EveOrg> createState() => _EveOrgState();
}

class _EveOrgState extends State<EveOrg> {
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
      body: Padding(
        padding: const EdgeInsets.all(20), // Add padding around the body
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align items to the left
          children: [
            const Text(
              '. Organize Your Event .',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(
                height: 25), // Add space between the heading and the button
            SizedBox(
              width:
                  double.infinity, // Set the width of all buttons to full width
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'create-attendee');
                },
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all(const Color(0xFFfcf6db)),
                  padding: WidgetStateProperty.all(
                    const EdgeInsets.symmetric(
                        vertical:
                            25), // Adjust vertical padding for uniform size
                  ),
                ),
                child: const Text(
                  'ATTENDEES',
                  style: TextStyle(
                    color: Colors.teal, // Teal-colored text
                    fontWeight: FontWeight.normal, // Ensure text is not bold
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'create-items');
                },
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all(const Color(0xFFfcf6db)),
                  padding: WidgetStateProperty.all(
                    const EdgeInsets.symmetric(vertical: 25),
                  ),
                ),
                child: const Text(
                  'ITEMS REQUIRED',
                  style: TextStyle(
                    color: Colors.teal,
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'create-music');
                },
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all(const Color(0xFFfcf6db)),
                  padding: WidgetStateProperty.all(
                    const EdgeInsets.symmetric(vertical: 25),
                  ),
                ),
                child: const Text(
                  'MUSIC LIST',
                  style: TextStyle(
                    color: Colors.teal,
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'create-menu');
                },
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all(const Color(0xFFfcf6db)),
                  padding: WidgetStateProperty.all(
                    const EdgeInsets.symmetric(vertical: 25),
                  ),
                ),
                child: const Text(
                  'MENU',
                  style: TextStyle(
                    color: Colors.teal,
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'create-stall');
                },
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all(const Color(0xFFfcf6db)),
                  padding: WidgetStateProperty.all(
                    const EdgeInsets.symmetric(vertical: 25),
                  ),
                ),
                child: const Text(
                  'STALLS',
                  style: TextStyle(
                    color: Colors.teal,
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
