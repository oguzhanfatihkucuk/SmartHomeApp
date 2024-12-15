class Device {
  final String name;
  final String icon;
  bool isOn;

  Device({
    required this.name,
    required this.icon,
    required this.isOn,
  });

  factory Device.fromJson(Map<dynamic, dynamic> json) {
    return Device(
      name: json['name'] as String,
      icon: json['icon'] as String,
      isOn: json['isOn'] as bool,
    );
  }
}