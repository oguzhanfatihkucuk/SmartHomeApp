import 'package:flutter/material.dart';
import '../../Components/DeviceCard.dart';
import '../../assets/RoomsList.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ana Sayfa')),
      body: ListView.builder(
        itemCount: rooms.length, // Her oda için bir liste oluştur
        itemBuilder: (context, roomIndex) {
          final room = rooms[roomIndex];
          final roomDevices = room['devices'] as List; // Odanın cihazları
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  room['name'], // Oda adı
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 200, // Kartların yüksekliği
                child: ListView.builder(
                  scrollDirection: Axis.horizontal, // Yatay kaydırma
                  itemCount: roomDevices.length,
                  itemBuilder: (context, deviceIndex) {
                    final device = roomDevices[deviceIndex];
                    return DeviceCard(
                      name: device["name"],
                      icon: device["icon"],
                      roomName: room['name'],
                      initialStatus: device["is_on"],
                      onToggle: (newStatus) {
                        // JSON verisini güncelle
                        setState(() {
                          device['is_on'] = newStatus; // Cihaz durumunu güncelle
                        });
                      },
                    );
                  },
                ),
              ),

            ],
          );
        },
      ),
    );
  }
}
