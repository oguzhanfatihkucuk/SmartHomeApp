import 'package:flutter/material.dart';
import '../../Components/RoomsCard.dart';
import '../../models/DeviceModel/DeviceModel.dart';

class RoomDetailScreen extends StatelessWidget {
  final String roomName;
  final String roomImage;
  final List<Device> devices;
  final VoidCallback onDelete; // Silme işlemi sonrası çağrılacak fonksiyon

  const RoomDetailScreen({
    Key? key,
    required this.roomName,
    required this.roomImage,
    required this.devices,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(roomName),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              _showDeleteConfirmation(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  roomImage,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Cihazlar (${devices.length})",
                style:
                const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: devices.length,
                itemBuilder: (context, index) {
                  final device = devices[index];
                  return RoomsCard(
                    name: device.name,
                    icon: _getIconData(device.icon),
                    isInitiallyOn: device.isOn,
                    onToggle: (bool newValue) {
                      // Cihaz durumu değiştiğinde listeyi güncelle
                      devices[index].isOn = newValue;
                    },
                  );
                },
              ),
            ],
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
      case "Icons.phone_android":
        return Icons.phone_android;
      default:
        return Icons.device_unknown; // Varsayılan ikon
    }
  }
  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Odayı Sil"),
          content: const Text("Bu odayı silmek istediğinizden emin misiniz?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Onay verilmezse diyalog kapatılır
              },
              child: const Text("İptal"),
            ),
            ElevatedButton(
              onPressed: () {
                onDelete(); // Silme işlemini tetikleyerek listeyi güncelle
                Navigator.pop(context); // Diyalog kapatılır
                Navigator.pop(context); // Detay sayfası kapatılır
              },
              child: const Text("Sil"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
            ),
          ],
        );
      },
    );
  }
}
