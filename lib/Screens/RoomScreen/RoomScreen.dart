import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../models/DeviceModel/DeviceModel.dart';
import '../../models/RoomModel/RoomModel.dart';
import 'RoomsDetails.dart';
import '../../Components/RoomAddForm.dart';

class RoomScreen extends StatefulWidget {
  @override
  _RoomScreenState createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  late List<Room> rooms = [];

  final database = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL: 'https://smarthomeapp-ed852-default-rtdb.asia-southeast1.firebasedatabase.app',
  );

  @override
  void initState() {
    super.initState();
    _fetchRooms();
  }

  // Firebase'den odaları çekme
  Future<void> _fetchRooms() async {
    try {
      final snapshot = await database.ref('rooms').once();
      final data = snapshot.snapshot.value as Map<dynamic, dynamic>;

      setState(() {
        rooms = data.entries.map((entry) {
          final roomData = entry.value as Map<dynamic, dynamic>;
          return Room.fromJson(roomData);
        }).toList();
      });
    } catch (e) {
      print('Error fetching rooms: $e');
      // Hata durumunda yapılacak işlemleri buraya ekleyebilirsiniz
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Odalarım"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddRoomForm,
          ),
        ],
      ),
      body: rooms.isEmpty
          ? Center(child: CircularProgressIndicator()) // Veri yükleniyorsa gösterilecek widget
          : ListView.builder(
        itemCount: rooms.length,
        itemBuilder: (context, index) {
          final room = rooms[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RoomDetailScreen(
                    roomName: room.name,
                    roomImage: room.image,
                    devices: room.devices,
                    onDelete: () {
                      setState(() {
                        rooms.removeAt(index);
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
                        room.image,
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        room.name,
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
                            "${room.devices.length} cihaz",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const Spacer(),
                          ...room.devices
                              .map((device) => Icon(
                            Icons.device_hub,
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

  // Oda ekleme formunu gösteren fonksiyon
  void _showAddRoomForm() {
    showDialog(
      context: context,
      builder: (context) {
        return AddRoomForm(
          onRoomAdded: (String name, String image, int deviceCount) {
            setState(() {
              rooms.add(Room(
                name: name,
                image: image,
                devices: List.generate(
                  deviceCount,
                      (index) => Device(
                    name: "Cihaz ${index + 1}",
                    icon: "Icons.device_hub", // İconlar burada dinamik olabilir
                    isOn: false,
                  ),
                ),
              ));
            });
          },
        );
      },
    );
  }
}
