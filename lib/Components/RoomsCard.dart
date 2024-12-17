import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoomsCard extends StatefulWidget {
  final String name;
  final IconData icon;
  final bool isInitiallyOn; // Başlangıç durumu
  final ValueChanged<bool>onToggle; // Dışarıya durum değişikliğini iletmek için callback


  const RoomsCard({
    Key? key,
    required this.name,
    required this.icon,
    required this.isInitiallyOn,
    required this.onToggle,
  }) : super(key: key);

  @override
  _DeviceCardState createState() => _DeviceCardState();
}

class _DeviceCardState extends State<RoomsCard> {
  late bool isOn;

  @override
  void initState() {
    super.initState();
    isOn = widget.isInitiallyOn; // Başlangıç durumunu al
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          widget.icon,
          size: 32,
          color: isOn ? Colors.blue : Colors.grey, // Duruma göre renk değiştir
        ),
        title: Text(
          widget.name,
          style: const TextStyle(fontSize: 18),
        ),
        trailing: Switch(
          value: isOn,
          onChanged: (value) {
            setState(() {
              isOn = value;
            });
            widget.onToggle(value); // Durum değişikliğini dışarıya aktar
          },
        ),
      ),
    );
  }
}
