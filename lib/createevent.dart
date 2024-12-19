import 'package:flutter/material.dart';
import 'package:evezo/data/local/db_helper.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key});

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  DateTime? startDate;
  DateTime? endDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  // Controllers for TextFields
  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _eventTypeController = TextEditingController();
  final TextEditingController _eventLocationController =
  TextEditingController();

  Future<void> _pickDate(BuildContext context, bool isStartDate) async {
    DateTime initialDate =
    isStartDate ? startDate ?? DateTime.now() : endDate ?? DateTime.now();
    DateTime firstDate = DateTime(2000);
    DateTime lastDate = DateTime(2100);

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    setState(() {
      if (isStartDate) {
        startDate = pickedDate;
      } else {
        endDate = pickedDate;
      }
    });
  }

  Future<void> _pickTime(BuildContext context, bool isStartTime) async {
    TimeOfDay initialTime =
    isStartTime ? startTime ?? TimeOfDay.now() : endTime ?? TimeOfDay.now();

    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (pickedTime != null) {
      setState(() {
        if (isStartTime) {
          startTime = pickedTime;
        } else {
          endTime = pickedTime;
        }
      });
    }
  }

  // Save Event to the Database
  Future<void> _saveEvent() async {
    if (_eventNameController.text.isEmpty ||
        _eventTypeController.text.isEmpty ||
        _eventLocationController.text.isEmpty ||
        startDate == null ||
        endDate == null ||
        startTime == null ||
        endTime == null) {
      _showSnackBar("Please fill in all fields.");
      return;
    }

    String startDateStr = startDate.toString().split(' ')[0];
    String endDateStr = endDate.toString().split(' ')[0];
    String startTimeStr = startTime!.format(context);
    String endTimeStr = endTime!.format(context);

    await DBHelper.instance.getDB().then((db) async {
      await db.insert(DBHelper.instance.tableEvent, {
        DBHelper.instance.columnEventId: _eventNameController.text,
        DBHelper.instance.columnEventType: _eventTypeController.text,
        DBHelper.instance.columnEventLocation: _eventLocationController.text,
        DBHelper.instance.columnEventStartDate: startDateStr,
        DBHelper.instance.columnEventEndDate: endDateStr,
        DBHelper.instance.columnEventStartTime: startTimeStr,
        DBHelper.instance.columnEventEndTime: endTimeStr,
      });
    });

    _showSnackBar("Event saved successfully!");
    _clearForm();
  }

  void _clearForm() {
    setState(() {
      _eventNameController.clear();
      _eventTypeController.clear();
      _eventLocationController.clear();
      startDate = null;
      endDate = null;
      startTime = null;
      endTime = null;
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.teal),
    );
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
            padding: const EdgeInsets.only(left: 46, top: 20, right: 10),
            child: const Text(
              '. Create Your Event .',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.13,
                  right: 35,
                  left: 35),
              child: Column(
                children: [
                  // Event Name
                  TextField(
                    controller: _eventNameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFfcf6db),
                      hintText: 'Enter Event Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Event Type
                  TextField(
                    controller: _eventTypeController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFfcf6db),
                      hintText: 'Enter Event Type',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Event Location
                  TextField(
                    controller: _eventLocationController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFfcf6db),
                      hintText: 'Enter Event Location',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Start Date
                  TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFfcf6db),
                      hintText: startDate != null
                          ? 'Start Date: ${startDate!.toLocal().toString().split(' ')[0]}'
                          : 'Enter Start Date',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: () => _pickDate(context, true),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // End Date
                  TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFfcf6db),
                      hintText: endDate != null
                          ? 'End Date: ${endDate!.toLocal().toString().split(' ')[0]}'
                          : 'Enter End Date',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: () => _pickDate(context, false),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Start Time
                  TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFfcf6db),
                      hintText: startTime != null
                          ? 'Start Time: ${startTime!.format(context)}'
                          : 'Enter Start Time',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.access_time),
                        onPressed: () => _pickTime(context, true),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // End Time
                  TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFfcf6db),
                      hintText: endTime != null
                          ? 'End Time: ${endTime!.format(context)}'
                          : 'Enter End Time',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.access_time),
                        onPressed: () => _pickTime(context, false),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: const Color(0xFF3f6267),
                        child: IconButton(
                          color: Colors.white,
                          onPressed: _saveEvent, // Save Button Functionality
                          icon: const Icon(Icons.arrow_forward),
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
