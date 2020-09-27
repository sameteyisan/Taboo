import 'dart:math';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:Taboo/baslamadan_once.dart';
import 'package:Taboo/json.dart';
import 'package:Taboo/sonuc_ekrani.dart';
import 'package:Taboo/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:timer_count_down/timer_count_down.dart';

var _random = Random();

TaskModel gonderilen;
var anlikpuan = 0;
bool molaController = false;
var tabooPuanKacOlcak = 1;
var dogruPuankacOlcak = 1;
var pasHakkkiKac = 3;
var tabooPuan = 0;
var dogruPuan = 0;
var pasHakki = 0;
var seconds = 60;
final assetsAudioPlayer = AssetsAudioPlayer();

class OyunEkrani extends StatefulWidget {
  OyunEkrani({
    Key key,
  }) : super(key: key);

  @override
  _OyunEkraniState createState() => _OyunEkraniState();
}

class _OyunEkraniState extends State<OyunEkrani> {
  @override
  void initState() {
    super.initState();
    assetsAudioPlayer.open(
      Audio("asset/audios/clock.mp3"),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TodoHelper _todoHelper = TodoHelper();
    var rnd = _random.nextInt(tabu.length);
    final Tabu tt = new Tabu.fromJson(tabu, rnd);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            molaController == false
                ? Column(
                    children: [
                      IconButton(
                        splashRadius: 20,
                        icon: Icon(
                          LineAwesomeIcons.pause,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            molaController = true;
                            assetsAudioPlayer.pause();
                          });
                        },
                      ),
                      Text(
                        'Mola',
                        style: TextStyle(color: Colors.black, fontSize: 10),
                      )
                    ],
                  )
                : Column(
                    children: [
                      IconButton(
                        splashRadius: 20,
                        icon: Icon(
                          LineAwesomeIcons.play,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            molaController = false;
                            assetsAudioPlayer.play();
                          });
                        },
                      ),
                      Text(
                        'Devam',
                        style: TextStyle(color: Colors.black, fontSize: 10),
                      )
                    ],
                  ),
            SizedBox(
              height: 100,
              width: 100,
              child: Image.asset('asset/images/tabuu.png'),
            ),
            Countdown(
              seconds: seconds,
              build: (BuildContext context, double time) => Container(
                alignment: Alignment.center,
                width: 200,
                height: 50,
                child: Text(
                  'Kalan Süre : ' + time.toInt().toString(),
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              interval: Duration(seconds: 1),
              onFinished: () async {
                gonderilen = sirakontrol % 2 == 0
                    ? TaskModel(takim1: anlikpuan, takim2: 0)
                    : TaskModel(takim1: 0, takim2: anlikpuan);
                await _todoHelper.insertTask(gonderilen);
                await _todoHelper.calculateTotal();
                setState(() {
                  assetsAudioPlayer.stop();
                  takim1Skor = takim1Skor;
                  takim2Skor = takim2Skor;
                });
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => SonucEkrani()),
                    (route) => false);
              },
            ),
          ],
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FlatButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            color: Colors.deepOrangeAccent,
            onPressed: () {
              if (pasHakkkiKac == 0) {
              } else {
                assetsAudioPlayer.open(
                  Audio("asset/audios/pas.mp3"),
                );
                setState(() {
                  anlikpuan += 0;
                  pasHakkkiKac -= 1;
                  pasHakki += 1;
                });
              }
            },
            child: Row(
              children: [
                Icon(
                  LineAwesomeIcons.redo,
                  color: Colors.white,
                ),
                Text('Pas (${pasHakkkiKac.toString()})',
                    style: TextStyle(color: Colors.white))
              ],
            ),
          ),
          FlatButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            color: Colors.red,
            onPressed: () {
              assetsAudioPlayer.open(
                Audio("asset/audios/false.mp3"),
              );
              setState(() {
                anlikpuan -= tabooPuanKacOlcak;
                tabooPuan += 1;
              });
            },
            child: Row(
              children: [
                Icon(
                  LineAwesomeIcons.frowning_face,
                  color: Colors.white,
                ),
                Text('Taboo', style: TextStyle(color: Colors.white))
              ],
            ),
          ),
          FlatButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            color: Colors.green,
            onPressed: () {
              assetsAudioPlayer.open(
                Audio("asset/audios/true.mp3"),
              );
              setState(() {
                anlikpuan += dogruPuankacOlcak;
                dogruPuan += 1;
              });
            },
            child: Row(
              children: [
                Icon(
                  LineAwesomeIcons.grinning_face,
                  color: Colors.white,
                ),
                Text('Doğru', style: TextStyle(color: Colors.white))
              ],
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Divider(
                    height: 10,
                    indent: 500.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      sirakontrol % 2 == 0
                          ? buildTakimNameTasarim(takim1Name.text)
                          : buildTakimNameTasarim(takim2Name.text),
                      Container(
                        alignment: Alignment.center,
                        width: 100,
                        height: 50,
                        child: Text(
                          'Skor : $anlikpuan',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 20,
                    indent: 500.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        ),
                        border: Border.all(width: 0.5, color: Colors.black)),
                    width: MediaQuery.of(context).size.width - 50,
                    height: MediaQuery.of(context).size.height - 312,
                    child: Column(
                      children: tabuList(tt),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildTakimNameTasarim(String takim) {
    return Container(
      alignment: Alignment.center,
      width: 200,
      height: 50,
      child: Text(
        takim,
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }

  List<Widget> tabuList(Tabu tt) {
    var widgets = [
      Container(
        alignment: Alignment.center,
        child: Text(
          tt.kelime,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
        ),
        width: MediaQuery.of(context).size.width - 50,
        height: 70,
        decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
            border: Border.all(width: 0.5, color: Colors.black)),
      ),
    ];

    for (var yasakli in tt.yasakli) {
      widgets.add(wordContainer(yasakli));
    }
    return widgets;
  }

  Container wordContainer(String word) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width - 50,
      height: MediaQuery.of(context).size.height / 6 - 50,
      color: Colors.white,
      child: Text(
        word,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }
}
