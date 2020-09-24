import 'package:Taboo/toplu_degisimler.dart';
import 'package:flutter/material.dart';

class NasilOynanir extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: backButton,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Column(
          children: [
            Text(
              'Nasıl Oynanır ?',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView(
          children: [Text('OYUN BİLGİLERE BURADA YER ALACAKTIR.')],
        ),
      ),
    );
  }
}
