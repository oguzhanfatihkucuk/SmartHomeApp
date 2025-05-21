import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../Components/RoomsCard.dart';
import '../../models/DeviceModel/DeviceModel.dart';
import 'package:http/http.dart' as http;
import '../../assets/IPAdress.dart';

//http://192.168.1.6/rpc/Shelly.GetStatus

final database = FirebaseDatabase.instanceFor(
  app: Firebase.app(),
  databaseURL: 'https://smarthomeapp-ed852-default-rtdb.asia-southeast1.firebasedatabase.app',
);

Future<void> updateDeviceStatus(String roomId, int deviceIndex, bool newStatus) async {
  //const ipAddress = '192.168.1.6';
  const relayEndpoint = '/relay/0';
  const onCommand = '?turn=on';
  const offCommand = '?turn=off';

  try {

    final devicePath = 'rooms/$roomId/devices/$deviceIndex/isOn';

    await database.ref(devicePath).set(newStatus);

    if(devicePath=='rooms/room1/devices/1/isOn' && newStatus==true)
      {
        final url = Uri.parse('http://$ipAddress$relayEndpoint$onCommand');
        final response = await http.get(url);
        if (response.statusCode == 200) {
          print('Shelly kapatma komutu gönderildi.');
        } else {
          print('Shelly kapatma komutu başarısız oldu: ${response.statusCode}');
        }
      }

    if(devicePath=='rooms/room1/devices/1/isOn' && newStatus==false )
    {
      final url = Uri.parse('http://$ipAddress$relayEndpoint$offCommand');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        print('Shelly kapatma komutu gönderildi.');
      } else {
        print('Shelly kapatma komutu başarısız oldu: ${response.statusCode}');
      }
    }



    print('Cihaz durumu başarıyla güncellendi.');
  } catch (e) {
    print('Hata: Cihaz durumu güncellenemedi: $e');
  }
}

class RoomDetailScreen extends StatefulWidget {
  final String roomName;
  final String roomImage;
  final List<Device> devices;
  final VoidCallback onDelete;

  const RoomDetailScreen({
    Key? key,
    required this.roomName,
    required this.roomImage,
    required this.devices,
    required this.onDelete,
  }) : super(key: key);

  @override
  _RoomDetailScreenState createState() => _RoomDetailScreenState();
}

class _RoomDetailScreenState extends State<RoomDetailScreen> {
  late List<Device> devices; // Lokal olarak güncellenebilir cihaz listesi

  @override
  void initState() {
    super.initState();
    devices = List.from(widget.devices); // Orijinal cihaz listesini kopyala
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.roomName),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  widget.roomImage,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Devices (${devices.length})",
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: devices.length,
                itemBuilder: (context, index) {
                  final device = devices[index];
                  return RoomsCard(
                    name: device.name,
                    icon: _getIconData(device.icon),
                    isInitiallyOn: device.isOn,
                    onToggle: (bool newValue) async {
                      try {
                        updateDeviceStatus(device.roomId,device.id,newValue);

                        setState(() {
                          devices[index].isOn = newValue;
                        });

                      } catch (e) {
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
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
      return Icons.device_unknown;
  }
}