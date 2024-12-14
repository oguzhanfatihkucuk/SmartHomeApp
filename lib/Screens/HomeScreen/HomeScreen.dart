import 'package:flutter/material.dart';
import '../../Components/DeviceCard.dart';
import '../../assets/RoomsList.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _command = "";

  @override
  void initState() {
    super.initState();
  }

  // Sesli komutları başlatma
  void _startListening() async {
    bool available = await _speech.initialize();
    if (available) {
      setState(() {
        _isListening = true;
        _command = "Sesli komut alınıyor...";
      });
      _speech.listen(
        onResult: (result) {
          setState(() {
            _command = result.recognizedWords;
          });
          _processCommand(result.recognizedWords);
        },
      );
    } else {
      setState(() {
        _isListening = false;
        _command = "Sesli komut özelliği aktif değil.";
      });
      print("Sesli komut özelliği aktif değil.");
    }
  }

  // Dinlemeyi durdurma
  void _stopListening() {
    _speech.stop();
    setState(() {
      _isListening = false;
    });
  }

  // Komutları işleme (örneğin cihazları açma/kapama)
  void _processCommand(String command) {
    // Komutlara göre işlemler
    if (command.contains("turn on the lights")) {
      setState(() {
        _command = "I have turned on the lights.";
      });
    } else if (command.contains("turn off the lights")) {
      setState(() {
        _command = "I have turned off the lights.";
      });
    } else if (command.contains("turn on the tv")) {
      setState(() {
        _command = "I have turned on the TV.";
      });
    } else {
      setState(() {
        _command = "Komut anlaşılamadı.";
      });
    }
  }



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
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {
              // Print the command and listening status when the button is pressed
              print("Command: $_command, Listening: $_isListening");

              // Start/Stop listening depending on the state
              _isListening ? _stopListening() : _startListening();
            },
            child: Icon(_isListening ? Icons.mic_off : Icons.mic),
            backgroundColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}
