import 'package:Taboo/oyun_ekrani.dart';
import 'package:Taboo/sonuc_ekrani.dart';
import 'package:Taboo/toplu_degisimler.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:nice_button/NiceButton.dart';

GlobalKey<ScaffoldState> _snackbarKey = new GlobalKey<ScaffoldState>();

class Ayarlar extends StatefulWidget {
  @override
  _AyarlarState createState() => _AyarlarState();
}

class _AyarlarState extends State<Ayarlar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _snackbarKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          splashRadius: 20,
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: NiceButton(
        background: Colors.amber,
        radius: 40,
        padding: const EdgeInsets.all(15),
        text: "Başlangıç Ayarlarına Dön",
        fontSize: 15,
        icon: LineAwesomeIcons.reply,
        gradientColors: [
          Colors.blue,
          Colors.amber,
        ],
        onPressed: () {
          Flushbar(
            boxShadows: [
              BoxShadow(
                  color: Colors.white,
                  offset: Offset(0.0, 2.0),
                  blurRadius: 3.0)
            ],
            backgroundGradient:
                LinearGradient(colors: [Colors.blue, Colors.amber]),
            flushbarPosition: FlushbarPosition.TOP,
            title: 'İşlem Başarılı',
            message: 'Başlangıç Ayarlarına Dönüldü.',
            duration: Duration(seconds: 1),
          )..show(context);
          setState(() {
            seconds = 60;
            bitisPuani = 20;
            dogruPuankacOlcak = 1;
            tabooPuanKacOlcak = 1;
          });
        },
      ),
      body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildText('Oyun Bitiş Puanı'),
              Slider(
                  value: bitisPuani.toDouble(),
                  onChanged: (yeniBitisPuani) {
                    setState(() => bitisPuani = yeniBitisPuani.toInt());
                  },
                  min: 20,
                  max: 50,
                  divisions: 3,
                  label: "Bitiş Puanı : $bitisPuani puan"),
              buildDivider(),
              buildText('Anlatıcı Süresi'),
              Slider(
                  activeColor: Colors.amber,
                  value: seconds.toDouble(),
                  onChanged: (yeniOyunSuresi) {
                    setState(() => seconds = yeniOyunSuresi.toInt());
                  },
                  min: 60,
                  max: 120,
                  divisions: 2,
                  label: "Süre : $seconds saniye"),
              buildDivider(),
              buildText('Doğru Cevap Puanı'),
              Slider(
                  activeColor: Colors.green,
                  value: dogruPuankacOlcak.toDouble(),
                  onChanged: (yeniDogruCevapKacOlcak) {
                    setState(() =>
                        dogruPuankacOlcak = yeniDogruCevapKacOlcak.toInt());
                  },
                  min: 1,
                  max: 3,
                  divisions: 2,
                  label: "Doğru Cevap Puanı : +$dogruPuankacOlcak"),
              buildDivider(),
              buildText('Tabu Puanı'),
              Slider(
                  activeColor: Colors.red,
                  value: tabooPuanKacOlcak.toDouble(),
                  onChanged: (yeniTabooPuanKacOlcak) {
                    setState(() =>
                        tabooPuanKacOlcak = yeniTabooPuanKacOlcak.toInt());
                  },
                  min: 1,
                  max: 3,
                  divisions: 2,
                  label: "Tabu Puanı : -$tabooPuanKacOlcak"),
            ],
          )),
    );
  }

  Text buildText(String text) => Text(text);

  Divider buildDivider() {
    return Divider(
      height: 20,
      indent: 500.0,
    );
  }
}
