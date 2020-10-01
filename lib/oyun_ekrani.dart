import 'dart:math';
import 'package:Taboo/game_over.dart';
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
var tabooPuanKacOlcak = 1;
var dogruPuankacOlcak = 1;
var pasHakkkiKac = 3;
var tabooPuan = 0;
var dogruPuan = 0;
var pasHakki = 0;
var seconds = 60;
final assetsAudioPlayer = AssetsAudioPlayer();
final assetsAudioPlayerClock = AssetsAudioPlayer();

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
    assetsAudioPlayerClock.open(
      Audio("asset/audios/clock.mp3"),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (tabu.length == 0) {
      setState(() {
        assetsAudioPlayerClock.stop();
        takim1Skor = takim1Skor;
        takim2Skor = takim2Skor;
      });
      return GameOver();
    }
    final TodoHelper _todoHelper = TodoHelper();
    var rnd = _random.nextInt(tabu.length);
    final Tabu tt = new Tabu.fromJson(tabu, rnd);
    return Scaffold(
      appBar: AppBar(
        actions: [
          SizedBox(
            height: 100,
            width: 100,
            child: Image.asset('asset/images/tabuu.png'),
          ),
          Spacer(
            flex: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Countdown(
              seconds: seconds,
              build: (BuildContext context, double time) => SizedBox(
                  child: Row(
                children: [
                  seconds == 120
                              ? time > 60
                                  ? Icon(
                                      LineAwesomeIcons.hourglass_start,
                                      color: Colors.black,
                                    )
                                  : time > 15
                                      ? Icon(
                                          LineAwesomeIcons.hourglass_half,
                                          color: Colors.black,
                                        )
                                      : Icon(
                                          LineAwesomeIcons.hourglass_end,
                                          color: time > 3
                                              ? Colors.black
                                              : Colors.red[700],
                                        )
                              : seconds == 90
                                  ? time > 45
                                      ? Icon(
                                          LineAwesomeIcons.hourglass_start,
                                          color: Colors.black,
                                        )
                                      : time > 15
                                          ? Icon(
                                              LineAwesomeIcons.hourglass_half,
                                              color: Colors.black,
                                            )
                                          : Icon(
                                              LineAwesomeIcons.hourglass_end,
                                              color: time > 3
                                                  ? Colors.black
                                                  : Colors.red[700],
                                            )
                                  : time > 30
                                      ? Icon(
                                          LineAwesomeIcons.hourglass_start,
                                          color: Colors.black,
                                        )
                                      : time > 10
                                          ? Icon(
                                              LineAwesomeIcons.hourglass_half,
                                              color: Colors.black,
                                            )
                                          : Icon(
                                              LineAwesomeIcons.hourglass_end,
                                              color: time > 3
                                                  ? Colors.black
                                                  : Colors.red[700],
                                            ),
                  Text(
                    time.toInt().toString() + ' Saniye',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: time > 3 ? Colors.black : Colors.red[700]),
                  ),
                ],
              )),
              onFinished: () async {
                gonderilen = sirakontrol % 2 == 0
                    ? TaskModel(takim1: anlikpuan, takim2: 0)
                    : TaskModel(takim1: 0, takim2: anlikpuan);
                await _todoHelper.insertTask(gonderilen);
                await _todoHelper.calculateTotal();
                setState(() {
                  tabu.removeAt(rnd);
                  assetsAudioPlayerClock.stop();
                  takim1Skor = takim1Skor;
                  takim2Skor = takim2Skor;
                });
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => SonucEkrani()),
                    (route) => false);
              },
            ),
          ),
        ],
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 3.6,
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
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
                    tabu.removeAt(rnd);
                  });
                }
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
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
          ),
          Container(
            width: MediaQuery.of(context).size.width / 3.6,
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              color: Colors.red,
              onPressed: () {
                assetsAudioPlayer.open(
                  Audio("asset/audios/false.mp3"),
                );
                setState(() {
                  anlikpuan -= tabooPuanKacOlcak;
                  tabooPuan += 1;
                  tabu.removeAt(rnd);
                });
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    LineAwesomeIcons.frowning_face,
                    color: Colors.white,
                  ),
                  Text('Tabu', style: TextStyle(color: Colors.white))
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 3.6,
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              color: Colors.green,
              onPressed: () {
                assetsAudioPlayer.open(
                  Audio("asset/audios/true.mp3"),
                );
                setState(() {
                  anlikpuan += dogruPuankacOlcak;
                  dogruPuan += 1;
                  tabu.removeAt(rnd);
                });
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    LineAwesomeIcons.grinning_face,
                    color: Colors.white,
                  ),
                  Text('Doğru', style: TextStyle(color: Colors.white))
                ],
              ),
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.all(0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  buildDivider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      sirakontrol % 2 == 0
                          ? buildTakimNameTasarim(takim1Name.text)
                          : buildTakimNameTasarim(takim2Name.text),
                      SizedBox(
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
                  buildDivider(),
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        )
                      ],
                      color: Colors.blue[300],
                    ),
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

  Divider buildDivider() {
    return Divider(
      height: 20,
      indent: 500.0,
    );
  }

  SizedBox buildTakimNameTasarim(String takim) {
    return SizedBox(
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
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 25),
        ),
        width: MediaQuery.of(context).size.width - 50,
        height: 70,
        decoration: BoxDecoration(
            color: Colors.blue[300],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
            border: Border.all(width: 0.5, color: Colors.blue[300])),
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
      color: Colors.blue[300],
      child: Text(
        word,
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }
}
