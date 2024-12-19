import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  /// Singleton instance
  DBHelper._();
  static final DBHelper instance = DBHelper._();

  // ===================== Table and Column Names =====================

  // Event Table
  final String tableEvent = "event";
  final String columnEventId = "id";
  final String columnEventName = "name";
  final String columnEventType = "type";
  final String columnEventLocation = "location";
  final String columnEventStartDate = "start_date";
  final String columnEventEndDate = "end_date";
  final String columnEventStartTime = "start_time";
  final String columnEventEndTime = "end_time";

  // User Table
  final String tableUser = "user";
  final String columnUserEmail = "email";
  final String columnUserPassword = "password";

  // Attendee Table
  final String tableAttendee = "attendee";
  final String columnAttendeeName = "name";
  final String columnAttendeePhone = "phone";
  final String columnAttendeeEmail = "email";
  final String columnAttendeeDietaryRestrictions = "dietary_restrictions";
  final String columnAttendeeAccessibilityRequirements =
      "accessibility_requirements";

  // Music Table
  final String tableMusic = "music";
  final String columnMusicId = "id";
  final String columnMusicSongName = "song_name";
  final String columnMusicArtistName = "artist_name";
  final String columnMusicSongNumber = "song_number";

  // Stall Table
  final String tableStall = "stall";
  final String columnStallId = "id";
  final String columnStallName = "stall_name";
  final String columnStallNumber = "stall_number";
  final String columnStallType = "stall_type";

  // Items Table
  final String tableItem = "item";
  final String columnItemId = "id";
  final String columnItemName = "name";
  final String columnItemCategory = "category";
  final String columnItemQuantity = "quantity";
  final String columnItemPriority = "priority";

  // ===================== Database Instance =====================
  Database? myDB;

  /// Initialize and open the database
  Future<Database> getDB() async {
    myDB ??= await openDB();
    return myDB!;
  }

  Future<Database> openDB() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    String dbPath = join(appDir.path, "evezo.db");

    return await openDatabase(dbPath, version: 1,
        onCreate: (db, version) async {
      // Event Table
      await db.execute("""
        CREATE TABLE $tableEvent (
          $columnEventId INTEGER PRIMARY KEY AUTOINCREMENT, 
          $columnEventName TEXT, 
          $columnEventType TEXT, 
          $columnEventLocation TEXT, 
          $columnEventStartDate TEXT, 
          $columnEventEndDate TEXT, 
          $columnEventStartTime TEXT, 
          $columnEventEndTime TEXT
        )
      """);

      // User Table
      await db.execute("""
        CREATE TABLE $tableUser (
          $columnUserEmail TEXT PRIMARY KEY, 
          $columnUserPassword TEXT
        )
      """);

      // Attendee Table
      await db.execute("""
        CREATE TABLE $tableAttendee (
          $columnAttendeeName TEXT, 
          $columnAttendeePhone TEXT, 
          $columnAttendeeEmail TEXT PRIMARY KEY, 
          $columnAttendeeDietaryRestrictions TEXT, 
          $columnAttendeeAccessibilityRequirements TEXT
        )
      """);

      // Music Table
      await db.execute("""
        CREATE TABLE $tableMusic (
          $columnMusicId INTEGER PRIMARY KEY AUTOINCREMENT, 
          $columnMusicSongName TEXT, 
          $columnMusicArtistName TEXT, 
          $columnMusicSongNumber INTEGER
        )
      """);

      // Stall Table
      await db.execute("""
        CREATE TABLE $tableStall (
          $columnStallId INTEGER PRIMARY KEY AUTOINCREMENT, 
          $columnStallName TEXT, 
          $columnStallNumber TEXT, 
          $columnStallType TEXT
        )
      """);

      // Items Table
      await db.execute("""
        CREATE TABLE $tableItem (
          $columnItemId INTEGER PRIMARY KEY AUTOINCREMENT, 
          $columnItemName TEXT, 
          $columnItemCategory TEXT, 
          $columnItemQuantity TEXT, 
          $columnItemPriority TEXT
        )
      """);
    });
  }

  // ===================== User Table Functions =====================
  Future<bool> addUser(
      {required String email, required String password}) async {
    var db = await getDB();
    int result = await db.insert(
        tableUser,
        {
          columnUserEmail: email,
          columnUserPassword: password,
        },
        conflictAlgorithm: ConflictAlgorithm.replace);
    return result > 0;
  }

  Future<Map<String, dynamic>?> getUser(String email) async {
    var db = await getDB();
    List<Map<String, dynamic>> result = await db.query(
      tableUser,
      where: "$columnUserEmail = ?",
      whereArgs: [email],
    );
    return result.isNotEmpty ? result.first : null;
  }

  // ===================== Event Table Functions =====================
  Future<bool> addEvent(Map<String, dynamic> eventData) async {
    var db = await getDB();
    int result = await db.insert(tableEvent, eventData);
    return result > 0;
  }

  Future<List<Map<String, dynamic>>> getAllEvents() async {
    var db = await getDB();
    return await db.query(tableEvent);
  }

  // ===================== Attendee Table Functions =====================
  Future<bool> addAttendee(Map<String, dynamic> attendeeData) async {
    var db = await getDB();
    int result = await db.insert(tableAttendee, attendeeData);
    return result > 0;
  }

  Future<List<Map<String, dynamic>>> getAllAttendees() async {
    var db = await getDB();
    return await db.query(tableAttendee);
  }

  // ===================== Music Table Functions =====================
  Future<bool> addMusic({
    required String songName,
    required String artistName,
    required int songNumber,
  }) async {
    var db = await getDB();
    int result = await db.insert(
        tableMusic,
        {
          columnMusicSongName: songName,
          columnMusicArtistName: artistName,
          columnMusicSongNumber: songNumber,
        },
        conflictAlgorithm: ConflictAlgorithm.replace);
    return result > 0;
  }

  Future<List<Map<String, dynamic>>> getAllMusic() async {
    var db = await getDB();
    return await db.query(tableMusic);
  }

  // ===================== Stall Table Functions =====================
  Future<bool> addStall({
    required String stallName,
    required String stallNumber,
    required String stallType,
  }) async {
    var db = await getDB();
    int result = await db.insert(tableStall, {
      columnStallName: stallName,
      columnStallNumber: stallNumber,
      columnStallType: stallType,
    });
    return result > 0;
  }

  Future<List<Map<String, dynamic>>> getAllStalls() async {
    var db = await getDB();
    return await db.query(tableStall);
  }

  // ===================== Items Table Functions =====================
  Future<bool> addItem({
    required String name,
    required String category,
    required String quantity,
    required String priority,
  }) async {
    var db = await getDB();
    int result = await db.insert(
        tableItem,
        {
          columnItemName: name,
          columnItemCategory: category,
          columnItemQuantity: quantity,
          columnItemPriority: priority,
        },
        conflictAlgorithm: ConflictAlgorithm.replace);
    return result > 0;
  }

  Future<List<Map<String, dynamic>>> getAllItems() async {
    var db = await getDB();
    return await db.query(tableItem);
  }
}
