import 'package:flutter/material.dart';
import 'package:evezo/data/local/db_helper.dart';

class MusicList extends StatefulWidget {
  const MusicList({super.key});

  @override
  State<MusicList> createState() => _MusicListState();
}

class _MusicListState extends State<MusicList> {
  // Controllers for text input
  final TextEditingController _songNameController = TextEditingController();
  final TextEditingController _artistNameController = TextEditingController();
  final TextEditingController _songNumberController = TextEditingController();

  @override
  void dispose() {
    _songNameController.dispose();
    _artistNameController.dispose();
    _songNumberController.dispose();
    super.dispose();
  }

  Future<void> _saveMusicItem() async {
    String songName = _songNameController.text.trim();
    String artistName = _artistNameController.text.trim();
    int songNumber = int.tryParse(_songNumberController.text) ?? 0;

    if (songName.isNotEmpty && artistName.isNotEmpty && songNumber > 0) {
      bool success = await DBHelper.instance.addMusic(
        songName: songName,
        artistName: artistName,
        songNumber: songNumber,
      );

      if (!mounted) return; // Ensure the widget is still in the tree

      final snackBar = SnackBar(
        content: Text(success
            ? 'Music item saved successfully!'
            : 'Failed to save music item.'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      if (success) {
        _clearFields();
      }
    } else {
      if (!mounted) return; // Ensure the widget is still in the tree

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields correctly.')),
      );
    }
  }

  void _clearFields() {
    _songNameController.clear();
    _artistNameController.clear();
    _songNumberController.clear();
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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 35,
            vertical: MediaQuery.of(context).size.height * 0.1,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '. Organize Your Event .',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Enter Music Info',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _songNameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFfcf6db),
                  hintText: 'Enter Song Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _artistNameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFfcf6db),
                  hintText: 'Enter Artist Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _songNumberController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFfcf6db),
                  hintText: 'Enter Song Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3f6267),
                  ),
                  onPressed: _saveMusicItem,
                  child: const Text(
                    'Done',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
