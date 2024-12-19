import 'package:evezo/createevent.dart';
import 'package:evezo/items.dart';
import 'package:evezo/music.dart';
import 'package:evezo/organizeeve.dart';
import 'package:evezo/register.dart';
import 'package:flutter/material.dart';
import 'logopage.dart';
import 'signin.dart';
import 'attendee.dart';
import 'menu.dart';
import 'stalls.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'logo', // Match the route name
    routes: {
      'logo': (context) => const LogoPage(),
      'login': (context) => const SignIn(),
      'register': (context) => const Register(), //create event
      'create-event': (context) => const CreateEvent(),
      'organize-event': (context) => const EveOrg(),
      'create-attendee': (context) => const AttendeeInfo(),
      'create-items': (context) => const ItemsInfo(),
      'create-music': (context) => const MusicList(),
      'create-menu': (context) => const MenuInfo(),
      'create-stall': (context) => const StallInfo(),
    },
  ));
}
