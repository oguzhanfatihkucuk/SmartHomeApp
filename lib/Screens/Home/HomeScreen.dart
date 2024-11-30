import 'package:flutter/material.dart';
import '../../Components/DeviceCard.dart';
import '../../assests/RoomsList.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // Yalnızca `is_on: true` olan cihazları filtrele
    final filteredDevices = rooms.expand((room) {
      return (room['devices'] as List)
          .map((device) => {
        'name': device['name'],
        'icon': device['icon'],
        'roomName': room['name'],
        'is_on': device['is_on'], // Durumu da ekliyoruz
        'room': room, // Güncelleme için oda referansı
      });
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Ana Sayfa')),
      body: Center(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Her satırda 2 cihaz göstermek için
            crossAxisSpacing: 8.0, // Dikey boşluk
            mainAxisSpacing: 8.0, // Yatay boşluk
          ),
          itemCount: filteredDevices.length,
          itemBuilder: (context, index) {
            final device = filteredDevices[index];

            return DeviceCard(
              name: device["name"],
              icon: device["icon"],
              roomName: device["roomName"],
              initialStatus: device["is_on"],
              onToggle: (newStatus) {
                // JSON verisini güncelle
                setState(() {
                  // Oda referansı üzerinden cihazı bul ve durumunu değiştir
                  final room = device['room'];
                  final devices = room['devices'] as List;
                  final targetDevice = devices.firstWhere(
                          (d) => d['name'] == device['name']); // Doğru cihazı bul
                  targetDevice['is_on'] = newStatus; // JSON verisini güncelle
                });
              },
            );
          },
        ),
      ),
    );
  }
}
