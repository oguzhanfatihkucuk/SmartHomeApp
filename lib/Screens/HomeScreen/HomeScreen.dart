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
  bool isProcessing = false;


  @override
  void initState() {
    super.initState();
    _fetchRooms();

  }



  void _startListening() async {
    bool available = await _speech.initialize();
    print("Dinleme başlatıldı");
    if (available) {
      setState(() {
        _isListening = true;
      });
      _speech.listen(
        onResult: (result) {
          _processCommand(result.recognizedWords);
          print(result.recognizedWords);
          setState(() {
            _isListening = false;
          });
        },
      );
    }
  }

  void _stopListening() async {
    _speech.stop();
    print("Dinleme Durduruldu");
    setState(() {
      _isListening = false;
    });
  }

  void _processCommand(String command) async {
    if (command.contains("turn on the lights")) {
      const devicePath = 'rooms/room1/devices/1/isOn';
      await database.ref(devicePath).set(true);
    } else if (command.contains("turn off the lights")) {
      const devicePath = 'rooms/room1/devices/1/isOn';
      await database.ref(devicePath).set(false);
    } else if (command.contains("turn on the TV")) {
      const devicePath = 'rooms/room1/devices/0/isOn';
    } else if (command.contains("turn off the TV")) {
      const devicePath = 'rooms/room1/devices/0/isOn';
      await database.ref(devicePath).set(false);
    } else {
      setState(() {
        _command = "Komut anlaşılamadı.";
      });
      print(_command);
    }
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
    }
  }

  Future<void> turnOffAllDevices(bool statusOfDevices) async {
    try {
      setState(() {
        isProcessing = true;
      });

      final roomsPath = 'rooms';
      final roomsSnapshot = await database.ref(roomsPath).get();

      if (roomsSnapshot.exists) {
        final rooms = roomsSnapshot.value as Map;

        for (final roomId in rooms.keys) {
          final devicesPath = 'rooms/$roomId/devices';
          final devicesSnapshot = await database.ref(devicesPath).get();

          if (devicesSnapshot.exists) {
            final devices = devicesSnapshot.value as List;

            for (int deviceIndex = 0; deviceIndex < devices.length; deviceIndex++) {
              final devicePath = '$devicesPath/$deviceIndex/isOn';
              await database.ref(devicePath).set(statusOfDevices);
            }
          }
        }
      }

      print("Tüm cihazlar başarıyla güncellendi.");

    } catch (e) {
      print("Hata: $e");
    } finally {
      setState(() {
        isProcessing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const Text('Home Page'),
        actions: [
          Tooltip(
            message: 'Tüm cihazları kapat',
            child: IconButton(
              onPressed: isProcessing
                  ? null
                  : () async => await turnOffAllDevices(false),
              icon: Icon(Icons.flash_off),
            ),
          ),
          Tooltip(
            message: 'Tüm cihazları aç',
            child: IconButton(
              onPressed: isProcessing
                  ? null
                  : () async => await turnOffAllDevices(true),
              icon: Icon(Icons.flash_on),
            ),
          ),
        ],
      ),
      body: rooms.isEmpty || isProcessing
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        padding: EdgeInsets.only(bottom: 56),
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
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 200),
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
              )
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