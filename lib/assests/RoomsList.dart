import 'package:flutter/material.dart';

final List<Map<String, dynamic>> rooms = [
  {
    "name": "Oturma Odası",
    "image": "https://plus.unsplash.com/premium_photo-1675615667752-2ccda7042e7e?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "devices": [
      {"name": "Havalandırma", "icon": Icons.ac_unit},
      {"name": "Akıllı Televizyon", "icon": Icons.tv},
      {"name": "Akıllı Lamba 1", "icon": Icons.lightbulb},
      {"name": "Akıllı Lamba 2", "icon": Icons.lightbulb},
    ],
    "icons": [Icons.tv, Icons.ac_unit,Icons.lightbulb,Icons.lightbulb]
  },
  {
    "name": "Yatak Odası",
    "image": "https://images.unsplash.com/photo-1518012312832-96aea3c91144?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "devices": [
      {"name": "Akıllı Lamba 1", "icon": Icons.lightbulb},
      {"name": "Akıllı Lamba 2", "icon": Icons.lightbulb},
      {"name": "Akıllı Klima", "icon": Icons.ac_unit},
    ],
    "icons": [Icons.lightbulb, Icons.alarm]
  },
  {
    "name": "Mutfak",
    "image": "https://plus.unsplash.com/premium_photo-1680382578857-c331ead9ed51?q=80&w=1932&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "devices": [
      {"name": "Buzdolabı", "icon": Icons.kitchen},
      {"name": "Mikrodalga", "icon": Icons.microwave},
      {"name": "Akıllı Fırın", "icon": Icons.kitchen},
    ],
    "icons": [Icons.kitchen, Icons.microwave, Icons.lightbulb]
  },
  {
    "name": "Çalışma Odası",
    "image": "https://images.unsplash.com/photo-1497864768494-78100d1ddf01?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "devices": [
      {"name": "Akıllı Lamba 1", "icon": Icons.lightbulb},
    ],
    "icons": [Icons.desktop_windows, Icons.lightbulb]
  },
];