import 'package:flutter/material.dart';

final List<Map<String, dynamic>> rooms = [
  {
    "name": "Oturma Odası",
    "image": "https://plus.unsplash.com/premium_photo-1675615667752-2ccda7042e7e?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "devices": [
      {"name": "Havalandırma", "icon": Icons.ac_unit, "is_on": false},
      {"name": "Akıllı Televizyon", "icon": Icons.tv, "is_on": false},
      {"name": "Lamba", "icon": Icons.lightbulb, "is_on": false},
      {"name": "Perde", "icon": Icons.window, "is_on": false},
    ],
  },
  {
    "name": "Yatak Odası",
    "image": "https://plus.unsplash.com/premium_photo-1675615667752-2ccda7042e7e?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "devices": [
      {"name": "Akıllı Lamba", "icon": Icons.lightbulb, "is_on": false},
      {"name": "Akıllı Klima", "icon": Icons.ac_unit, "is_on": false},
      {"name": "Alarm Saati", "icon": Icons.alarm, "is_on": false},
      {"name": "Telefon Şarj", "icon": Icons.phone_android, "is_on": false},
    ],
  },
];

