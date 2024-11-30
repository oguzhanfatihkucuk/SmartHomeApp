import 'package:flutter/material.dart';

class DeviceCard extends StatefulWidget {
  final String name;
  final IconData icon;
  final String roomName;
  final bool initialStatus; // Başlangıç durumu
  final void Function(bool newStatus) onToggle; // Güncelleme işlemini bildirmek için callback

  const DeviceCard({
    Key? key,
    required this.name,
    required this.icon,
    required this.roomName,
    required this.initialStatus,
    required this.onToggle,
  }) : super(key: key);

  @override
  _DeviceCardState createState() => _DeviceCardState();
}

class _DeviceCardState extends State<DeviceCard> {
  late bool isOn;

  @override
  void initState() {
    super.initState();
    isOn = widget.initialStatus; // Başlangıç durumu
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isOn = !isOn; // Görünür durumu güncelle
        });

        // JSON verisindeki durumu güncellemek için callback'i çağır
        widget.onToggle(isOn);
      },
      borderRadius: BorderRadius.circular(12),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.icon,
                size: 48,
                color: isOn ? Colors.green : Colors.blue, // Duruma göre renk değişir
              ),
              const SizedBox(height: 8),
              Text(
                widget.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                "Oda: ${widget.roomName}",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
