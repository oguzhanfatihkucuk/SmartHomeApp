import 'package:flutter/material.dart';

class AddRoomForm extends StatefulWidget {
  final Function(String, String, int) onRoomAdded;

  const AddRoomForm({Key? key, required this.onRoomAdded}) : super(key: key);

  @override
  _AddRoomFormState createState() => _AddRoomFormState();
}

class _AddRoomFormState extends State<AddRoomForm> {
  final _formKey = GlobalKey<FormState>();
  String roomName = '';
  String roomImage = '';
  int deviceCount = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Yeni Oda Ekle"),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: "Oda Adı"),
              onSaved: (value) {
                roomName = value ?? '';
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Lütfen bir oda adı girin";
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: "Oda Resmi (URL)"),
              onSaved: (value) {
                roomImage = value ?? '';
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Lütfen bir resim URL'si girin";
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: "Cihaz Sayısı"),
              keyboardType: TextInputType.number,
              onSaved: (value) {
                deviceCount = int.tryParse(value ?? '0') ?? 0;
              },
              validator: (value) {
                if (value == null || int.tryParse(value) == null) {
                  return "Geçerli bir sayı girin";
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Formu iptal et
          },
          child: const Text("İptal"),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              widget.onRoomAdded(roomName, roomImage, deviceCount);
              Navigator.pop(context); // Form kapatılır
            }
          },
          child: const Text("Ekle"),
        ),
      ],
    );
  }
}
