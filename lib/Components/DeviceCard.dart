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
    return Card(
      child: InkWell(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(_getIconData(icon),color: isOn ?  Colors.lightGreen:Colors.red),
            Text(name),
            Text('Room: $roomName'),
          ],
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

