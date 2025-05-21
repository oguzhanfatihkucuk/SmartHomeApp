import 'dart:math';

import 'package:flutter/material.dart';

class DeviceCard extends StatelessWidget {
  final String name;
  final String icon;
  final String roomName;
  final bool initialStatus;
  final bool isOn;

  const DeviceCard({
    Key? key,
    required this.name,
    required this.icon,
    required this.isOn,
    required this.roomName,
    required this.initialStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final random = Random();
    final randomHours = 3 + random.nextInt(5); // 3 ile 7 arasında rastgele sayı

    return SizedBox(
      width: 175, // Sabit genişlik
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onLongPress: () {
            // Tıklama fonksiyonu
          },
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isOn ? Colors.lightGreen[100] : Colors.red[100],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _getIconData(icon),
                    color: isOn ? Colors.lightGreen : Colors.red,
                    size: 32,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  isOn
                      ? 'Open for $randomHours hours'
                      : 'Currently turned off', // Duruma göre yazı
                  style: TextStyle(
                    fontSize: 14,
                    color: isOn ? Colors.green[800] : Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case "Icons.ac_unit":
        return Icons.ac_unit;
      case "Icons.tv":
        return Icons.tv;
      case "Icons.lightbulb":
        return Icons.lightbulb;
      case "Icons.window":
        return Icons.window;
      case "Icons.alarm":
        return Icons.alarm;
      case "Icons.computer":
        return Icons.computer;
      case "Icons.kitchen":
        return Icons.kitchen;
      case "Icons.microwave":
        return Icons.microwave;
      case "Icons.blender":
        return Icons.blender;
      case "Icons.insert_drive_file":
        return Icons.insert_drive_file;
      case "Icons.phone_android":
        return Icons.phone_android;
      default:
        return Icons.device_unknown; // Varsayılan ikon
    }
  }
}
