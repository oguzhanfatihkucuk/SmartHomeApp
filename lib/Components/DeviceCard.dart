import 'package:flutter/material.dart';

class DeviceCard extends StatelessWidget {
  final String name;
  final String icon;
  final String roomName;
  final bool initialStatus;
  final Function(bool) onToggle;

  const DeviceCard({
    Key? key,
    required this.name,
    required this.icon,
    required this.roomName,
    required this.initialStatus,
    required this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          onToggle(!initialStatus);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(_getIconData(icon)),
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
      case "Icons.phone_android":
        return Icons.phone_android;
      default:
        return Icons.device_unknown; // Varsayılan ikon
    }
  }

}

