import 'dart:math';

import 'package:Taboo/baslamadan_once.dart';
import 'package:Taboo/json.dart';
import 'package:Taboo/sonuc_ekrani.dart';
import 'package:Taboo/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:timer_count_down/timer_count_down.dart';

var _random = Random();

List<TaskModel> tumHsepsi = [];
TaskModel gonderilen;
var anlikpuan = 0;
var tabooPuanKacOlcak = -1;
var dogruPuankacOlcak = 1;
var pasHakkkiKac = 3;
var tabooPuan = 0;
var dogruPuan = 0;
var pasHakki = 0;

class OyunEkrani extends StatefulWidget {
  OyunEkrani({
    Key key,
  }) : super(key: key);

  @override
  _OyunEkraniState createState() => _OyunEkraniState();
}

class _OyunEkraniState extends State<OyunEkrani> {
  @override
  Widget build(BuildContext context) {
    final TodoHelper _todoHelper = TodoHelper();

    var rnd = _random.nextInt(tabu.length);
    final Tabu tt = new Tabu.fromJson(tabu, rnd);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FlatButton(
            color: Colors.deepOrangeAccent,
            onPressed: () {
              setState(() {
                if (pasHakkkiKac == 0) {
                  return null;
                } else {
                  anlikpuan += 0;
                  print(anlikpuan);
                  pasHakkkiKac -= 1;
                  pasHakki += 1;
                }
              });
            },
            child: Row(
              children: [
                Icon(
                  LineAwesomeIcons.laughing_winking_face,
                  color: Colors.white,
                ),
                Text('Pas (${pasHakkkiKac.toString()})',
                    style: TextStyle(color: Colors.white))
              ],
            ),
          ),
          FlatButton(
            color: Colors.red,
            onPressed: () {
              setState(() {
                anlikpuan += tabooPuanKacOlcak;
                print(anlikpuan);
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
            color: Colors.green,
            onPressed: () {
              setState(() {
                anlikpuan += dogruPuankacOlcak;
                print(anlikpuan);
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
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.asset('asset/images/taboo.png'),
                      ),
                      Countdown(
                        seconds: 5,
                        build: (BuildContext context, double time) =>
                            Text('Kalan Süre : ' + time.toInt().toString()),
                        interval: Duration(seconds: 1),
                        onFinished: () {
                          gonderilen = sirakontrol % 2 == 0
                              ? TaskModel(
                                  takim1: anlikpuan.toString(), takim2: '0')
                              : TaskModel(
                                  takim1: '0', takim2: anlikpuan.toString());
                          _todoHelper.insertTask(gonderilen);
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SonucEkrani()),
                              (route) => false);
                          /*if (tak)
                          gonderilen = TaskModel(
                              );
                          _todoHelper.insertTask(gonderilen);*/
                        },
                      ),
                    ],
                  ),
                  Divider(
                    height: 20,
                    indent: 500.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      sirakontrol % 2 == 0
                          ? Text(
                              takim1Name.text,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          : Text(
                              takim2Name.text,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                      Text(
                        'Skor : $anlikpuan',
                        style: TextStyle(fontWeight: FontWeight.bold),
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
