import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../models/RoomModel/RoomModel.dart';
import 'RoomsDetails.dart';


class RoomScreen extends StatefulWidget {
  @override
  _RoomScreenState createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  late List<Room> rooms = [];

  final database = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL:
        'https://smarthomeapp-ed852-default-rtdb.asia-southeast1.firebasedatabase.app',
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
        forceMaterialTransparency: true,
        title: const Text("My Rooms"),
      ),
      body: rooms.isEmpty
          ? Center(
              child:
                  CircularProgressIndicator()) // Veri yükleniyorsa gösterilecek widget
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              children: [
                                Text(
                                  "${room.devices.length} device",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                const Spacer(),
                                ...room.devices
                                    .map((device) => Icon(
                                          _getIconData(device.icon),
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
