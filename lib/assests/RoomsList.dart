import 'package:flutter/material.dart';

final List<Map<String, dynamic>> rooms = [
  {
    "name": "Oturma Odası",
    "image": "https://plus.unsplash.com/premium_photo-1675615667752-2ccda7042e7e?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "devices": [
      {"name": "Havalandırma", "icon": Icons.ac_unit, "is_on": true},
      {"name": "Akıllı Televizyon", "icon": Icons.tv, "is_on": true},
      {"name": "Lamba", "icon": Icons.lightbulb, "is_on": false},
      {"name": "Perde", "icon": Icons.window, "is_on": true},
    ],
  },
  {
    "name": "Yatak Odası",
    "image": "https://plus.unsplash.com/premium_photo-1675615667752-2ccda7042e7e?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "devices": [
      {"name": "Akıllı Lamba", "icon": Icons.lightbulb, "is_on": true},
      {"name": "Akıllı Klima", "icon": Icons.ac_unit, "is_on": false},
      {"name": "Alarm Saati", "icon": Icons.alarm, "is_on": true},
      {"name": "Telefon Şarj", "icon": Icons.phone_android, "is_on": true},
    ],
  },
  {
    "name": "Mutfak",
    "image": "https://plus.unsplash.com/premium_photo-1675615667752-2ccda7042e7e?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "devices": [
      {"name": "Buzdolabı", "icon": Icons.kitchen, "is_on": true},
      {"name": "Mikrodalga", "icon": Icons.microwave, "is_on": false},
      {"name": "Fırın", "icon": Icons.alarm, "is_on": true},
      {"name": "Su Isıtıcı", "icon": Icons.coffee_maker, "is_on": true},
    ],
  },
  {
    "name": "Banyo",
    "image": "https://plus.unsplash.com/premium_photo-1675615667752-2ccda7042e7e?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "devices": [
      {"name": "Isıtıcı", "icon": Icons.fireplace, "is_on": true},
      {"name": "Ayna Işığı", "icon": Icons.lightbulb, "is_on": true},
      {"name": "Havalandırma Fanı", "icon": Icons.air, "is_on": false},
      {"name": "Duş Işığı", "icon": Icons.shower, "is_on": true},
    ],
  },
  {
    "name": "Çalışma Odası",
    "image": "https://plus.unsplash.com/premium_photo-1675615667752-2ccda7042e7e?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "devices": [
      {"name": "Bilgisayar", "icon": Icons.computer, "is_on": true},
      {"name": "Çalışma Lambası", "icon": Icons.lightbulb, "is_on": false},
      {"name": "Yazıcı", "icon": Icons.print, "is_on": true},
      {"name": "Hoparlör", "icon": Icons.speaker, "is_on": true},
    ],
  },
];

