import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:http/http.dart' as http;
import '../../Components/DeviceCard.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../assets/IPAdress.dart';
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
  List<Room> rooms = [];

  @override
  void initState() {
    super.initState();
    _fetchRooms();

  }

  void _startListening() async {
    bool available = await _speech.initialize();
    print("Dinleme başlatıldı");
    print(available);
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

  Future<void> sendShellyCommand(String command) async {
    //const ipAddress = '172.20.10.4';
    const relayEndpoint = '/relay/0';
    const onCommand = '?turn=on';
    const offCommand = '?turn=off';

    try {
      if (command.contains("turn on the lights")) {
        final url = Uri.parse('http://$ipAddress$relayEndpoint$onCommand');
        final response = await http.get(url);
        if (response.statusCode == 200) {
          print('Shelly açma komutu gönderildi.');
        } else {
          print('Shelly açma komutu başarısız oldu: ${response.statusCode}');
        }
      } else if (command.contains("turn off the lights")) {
        final url = Uri.parse('http://$ipAddress$relayEndpoint$offCommand');
        final response = await http.get(url);
        if (response.statusCode == 200) {
          print('Shelly kapatma komutu gönderildi.');
        } else {
          print('Shelly kapatma komutu başarısız oldu: ${response.statusCode}');
        }
      }
    } catch (e) {
      print('Shelly komutu gönderilirken bir hata oluştu: $e');
    }
  }

  void _processCommand(String command) async {
    if (command.contains("turn on the lights")) {
      const devicePath = 'rooms/room1/devices/1/isOn';
      await database.ref(devicePath).set(true);
      sendShellyCommand(command); // Shelly'ye komut gönder
    } else if (command.contains("turn off the lights")) {
      const devicePath = 'rooms/room1/devices/1/isOn';
      await database.ref(devicePath).set(false);
      sendShellyCommand(command); // Shelly'ye komut gönder
    } else if (command.contains("turn on the TV")) {
      const devicePath = 'rooms/room1/devices/0/isOn';
      await database.ref(devicePath).set(true); // TV kontrol mantığınızı buraya ekleyin
    } else if (command.contains("turn off the TV")) {
      const devicePath = 'rooms/room1/devices/0/isOn';
      await database.ref(devicePath).set(false); // TV kontrol mantığınızı buraya ekleyin
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const Text('Home Page'),
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