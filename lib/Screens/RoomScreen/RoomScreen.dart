import 'package:flutter/material.dart';
import '../../assests/RoomsList.dart';
import 'RoomsDetails.dart';
import '../../Components/RoomAddForm.dart';

class RoomScreen extends StatefulWidget {
  @override
  _RoomScreenState createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  late List<Map<String, dynamic>> roomList;

  @override
  void initState() {
    super.initState();
    roomList = List.from(rooms); // Başlangıçta `rooms` listesinin bir kopyasını al
  }

  void _showAddRoomForm() {
    showDialog(
      context: context,
      builder: (context) {
        return AddRoomForm(
          onRoomAdded: (String name, String image, int deviceCount) {
            setState(() {
              roomList.add({
                "name": name,
                "image": image,
                "devices": List.generate(
                  deviceCount,
                      (index) => {
                    "name": "Cihaz ${index + 1}",
                    "icon": Icons.device_hub,
                  },
                ),
              });
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Odalarım"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddRoomForm, // Yeni fonksiyon
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: roomList.length,
        itemBuilder: (context, index) {
          final room = roomList[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RoomDetailScreen(
                    roomName: room["name"],
                    roomImage: room["image"],
                    devices: room["devices"],
                    onDelete: () {
                      setState(() {
                        roomList.removeAt(index);
                      });
                    },
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                      child: Image.network(
                        room["image"],
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        room["name"],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          Text(
                            "${room["devices"].length} cihaz",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const Spacer(),
                          ...room["devices"]
                              .map((device) => Icon(
                            device["icon"],
                            color: Colors.blue,
                          ))
                              .toList(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
