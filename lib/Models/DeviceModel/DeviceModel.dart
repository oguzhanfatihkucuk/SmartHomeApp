class Device {
  final String name;
  final String icon;
  final int id;
  final String roomId;
  bool isOn;

  Device({
    required this.name,
    required this.icon,
    required this.isOn,
    required this.id,
    required this.roomId,
  });

  factory Device.fromJson(Map<dynamic, dynamic> json) {
    return Device(
      name: json['name'] as String,
      icon: json['icon'] as String,
      isOn: json['isOn'] as bool,
      id:json['id'] as int,
      roomId:json['roomId'] as String,

    );
  }


}