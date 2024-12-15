import '../DeviceModel/DeviceModel.dart';

class Room {
  final String name;
  final String image;
  final List<Device> devices;

  Room({
    required this.name,
    required this.image,
    required this.devices,
  });

  factory Room.fromJson(Map<dynamic, dynamic> json) {
    return Room(
      name: json['name'] as String,
      image: json['image'] as String,
      devices: (json['devices'] as List<dynamic>)
          .map((device) => Device.fromJson(device as Map<dynamic, dynamic>))
          .toList(),
    );
  }
}
