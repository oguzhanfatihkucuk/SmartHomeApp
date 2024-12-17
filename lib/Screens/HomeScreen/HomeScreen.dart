import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../../Components/DeviceCard.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../models/RoomModel/RoomModel.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Home Control',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _command = "";
  bool isProcessing = false; // İşlem durumu için bir değişken

  // Sesli komutları başlatma
  void _startListening() async {
    bool available = await _speech.initialize();

    if (available) {
      setState(() {
        _isListening = true;
      });
      _speech.listen(
        onResult: (result) {
          _processCommand(result.recognizedWords);
          setState(() {
            _isListening = false;
          });
        },
      );
    }
  }

  // Dinlemeyi durdurma
  void _stopListening() {
    _speech.stop();
    setState(() {
      _isListening = false;
    });
  }

  // Komutları işleme
  void _processCommand(String command) {
    if (command.contains("turn on the lights")) {
      setState(() {
        _command = "I have turned on the lights.";
      });
      print(_command);
    } else if (command.contains("turn off the lights")) {
      setState(() {
        _command = "I have turned off the lights.";
      });
      print(_command);
    } else if (command.contains("turn on the TV")) {
      setState(() {
        _command = "I have turned on the TV.";
      });
      print(_command);
    } else {
      setState(() {
        _command = "Komut anlaşılamadı.";
      });
      print(_command);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchRooms();
  }

  final database = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL:
        'https://smarthomeapp-ed852-default-rtdb.asia-southeast1.firebasedatabase.app',
  );

  List<Room> rooms = [];

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
      // Handle the error appropriately (e.g., show an error message to the user)
    }
  }

  Future<void> turnOffAllDevices(bool statusOfDevices) async {
    try {
      setState(() {
        isProcessing = true; // İşlem başladı
      });

      // Rooms path'i
      final roomsPath = 'rooms';

      // Firebase'den odaları al
      final roomsSnapshot = await database.ref(roomsPath).get();

      if (roomsSnapshot.exists) {
        // Rooms Map'ini al
        final rooms = roomsSnapshot.value as Map;

        // Her oda için döngü
        for (final roomId in rooms.keys) {
          // Odaya ait devices listesi
          final devicesPath = 'rooms/$roomId/devices';
          final devicesSnapshot = await database.ref(devicesPath).get();

          if (devicesSnapshot.exists) {
            final devices = devicesSnapshot.value as List;

            // Her cihazın isOn durumunu güncelle
            for (int deviceIndex = 0;
                deviceIndex < devices.length;
                deviceIndex++) {
              final devicePath = '$devicesPath/$deviceIndex/isOn';
              await database.ref(devicePath).set(statusOfDevices);

              _fetchRooms();
            }
          }
        }
      }

      print("Tüm cihazlar başarıyla güncellendi.");
    } catch (e) {
      print("Hata: $e");
    } finally {
      setState(() {
        isProcessing = false; // İşlem tamamlandı
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ana Sayfa'),
        actions: [
          IconButton(
            onPressed: isProcessing
                ? null // İşlem sırasında butonu devre dışı bırak
                : () async => await turnOffAllDevices(false),
            icon: Icon(Icons.delete),
          ),
          IconButton(
            onPressed: isProcessing
                ? null // İşlem sırasında butonu devre dışı bırak
                : () async => await turnOffAllDevices(true),
            icon: Icon(Icons.start),
          ),
        ],
      ),
      body: rooms.isEmpty
          ? Center(
              child:
                  CircularProgressIndicator()) // Veri yükleniyorsa gösterilecek widget
          : isProcessing
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: rooms.length,
                  itemBuilder: (context, roomIndex) {
                    final room = rooms[roomIndex];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            room.name,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 200,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: room.devices.length,
                            itemBuilder: (context, deviceIndex) {
                              final device = room.devices[deviceIndex];
                              return DeviceCard(
                                isOn: device.isOn,
                                name: device.name,
                                icon: device.icon,
                                roomName: room.name,
                                initialStatus: device.isOn,
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
      bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {
              _isListening ? _stopListening() : _startListening();
            },
            child: Icon(_isListening ? Icons.mic : Icons.mic_off),
            backgroundColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}
