import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// **RoomScreen**: Odalar ekranı
class RoomScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Odalar')),
      body: Center(
        child: Text(
          'Odalar Ekranı',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}