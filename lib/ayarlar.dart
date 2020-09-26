import 'package:Taboo/oyun_ekrani.dart';
import 'package:Taboo/sonuc_ekrani.dart';
import 'package:Taboo/toplu_degisimler.dart';
import 'package:flutter/material.dart';

class Ayarlar extends StatefulWidget {
  @override
  _AyarlarState createState() => _AyarlarState();
}

class _AyarlarState extends State<Ayarlar> {
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
              'Ayarlar',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Oyun Bitiş Puanı'),
              Slider(
                  value: bitisPuani.toDouble(),
                  onChanged: (yeniBitisPuani) {
                    setState(() => bitisPuani = yeniBitisPuani.toInt());
                  },
                  min: 25,
                  max: 100,
                  divisions: 3,
                  label: "Bitiş Puanı : $bitisPuani"),
              buildDivider(),
              Text('Zaman'),
              Slider(
                  activeColor: Colors.amber,
                  value: seconds.toDouble(),
                  onChanged: (yeniOyunSuresi) {
                    setState(() => seconds = yeniOyunSuresi.toInt());
                  },
                  min: 60,
                  max: 180,
                  divisions: 4,
                  label: "Zaman : $seconds"),
              buildDivider(),
              Text('Doğru Cevap Puanı'),
              Slider(
                  activeColor: Colors.green,
                  value: dogruPuankacOlcak.toDouble(),
                  onChanged: (yeniDogruCevapKacOlcak) {
                    setState(() =>
                        dogruPuankacOlcak = yeniDogruCevapKacOlcak.toInt());
                  },
                  min: 1,
                  max: 5,
                  divisions: 4,
                  label: "Doğru Cevap Puanı : $dogruPuankacOlcak"),
              buildDivider(),
              Text('Taboo Puanı'),
              Slider(
                  activeColor: Colors.red,
                  value: tabooPuanKacOlcak.toDouble(),
                  onChanged: (yeniTabooPuanKacOlcak) {
                    setState(() =>
                        tabooPuanKacOlcak = yeniTabooPuanKacOlcak.toInt());
                  },
                  min: 1,
                  max: 5,
                  divisions: 4,
                  label: "Taboo Puanı : -$tabooPuanKacOlcak"),
            ],
          )),
    );
  }

  Divider buildDivider() {
    return Divider(
      height: 10,
      indent: 500.0,
    );
  }
}
