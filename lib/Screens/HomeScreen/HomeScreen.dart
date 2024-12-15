import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../../assets/RoomsList.dart';
import '../../Components/DeviceCard.dart';

void main() {
  runApp(const MyApp());
}

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
  stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _command = "";

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
      print("I have turned on the lights.");
    } else if (command.contains("turn off the lights")) {
      setState(() {
        _command = "I have turned off the lights.";
      });
      print("I have turned off the lights.");
    } else if (command.contains("turn on the TV")) {
      setState(() {
        _command = "I have turned on the TV.";
      });
      print("I have turned on the TV.");
    } else {
      setState(() {
        _command = "Komut anlaşılamadı.";
      });
      print("Komut anlaşılamadı.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ana Sayfa')),
      body: ListView.builder(
        itemCount: rooms.length,
        itemBuilder: (context, roomIndex) {
          final room = rooms[roomIndex];
          final roomDevices = room['devices'] as List;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  room['name'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: roomDevices.length,
                  itemBuilder: (context, deviceIndex) {
                    final device = roomDevices[deviceIndex];
                    return DeviceCard(
                      name: device["name"],
                      icon: device["icon"],
                      roomName: room['name'],
                      initialStatus: device["is_on"],
                      onToggle: (newStatus) {
                        setState(() {
                          device['is_on'] = newStatus;
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
      bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {
              _isListening ?  _stopListening():_startListening() ;
            },
            child: Icon(_isListening ? Icons.mic : Icons.mic_off),
            backgroundColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}
