import 'package:Taboo/baslamadan_once.dart';
import 'package:Taboo/main.dart';
import 'package:Taboo/oyun_ekrani.dart';
import 'package:Taboo/sqflite.dart';
import 'package:Taboo/toplu_degisimler.dart';
import 'package:flutter/material.dart';
import 'package:nice_button/NiceButton.dart';

var takim1Skor = 0;
var takim2Skor = 0;
var sirakontrol = 0;
var bitisPuani = 20;

class SonucEkrani extends StatefulWidget {
  @override
  _SonucEkraniState createState() => _SonucEkraniState();
}

class _SonucEkraniState extends State<SonucEkrani> {
  final TodoHelper _todoHelper = TodoHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Column(
            children: [
              Text(
                'Sonuçlar',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: takim1Skor < bitisPuani
            ? NiceButton(
                background: Colors.amber,
                radius: 40,
                padding: const EdgeInsets.all(15),
                text: "Sıradaki Takımdan Devam Et",
                fontSize: 15,
                icon: teamIcon.icon,
                gradientColors: [
                  Colors.blue,
                  Colors.amber,
                ],
                onPressed: () {
                  setState(() {
                    sirakontrol += 1;
                    tabooPuan = 0;
                    dogruPuan = 0;
                    pasHakki = 0;
                    pasHakkkiKac = 3;
                    anlikpuan = 0;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OyunEkrani()),
                  );
                },
              )
            : NiceButton(
                background: Colors.amber,
                radius: 40,
                padding: const EdgeInsets.all(15),
                text: "Yeni Oyun Başlat",
                fontSize: 15,
                icon: teamIcon.icon,
                gradientColors: [
                  Colors.red,
                  Colors.green,
                  Colors.amber,
                  Colors.blue,
                ],
                onPressed: () async {
                  setState(() {
                    takim1Name.text = '';
                    takim2Name.text = '';
                  });
                  await _todoHelper.delete();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => MyApp()),
                      (route) => false);
                },
              ),
        body: takim1Skor < bitisPuani
            ? Container(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.blue[300],
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      width: MediaQuery.of(context).size.width - 50,
                      height: MediaQuery.of(context).size.height - 343,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            width: MediaQuery.of(context).size.width - 50,
                            height: 70,
                            child: sirakontrol % 2 == 0
                                ? Text(
                                    takim1Name.text,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : Text(
                                    takim2Name.text,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                          buildContainer('Doğru Sayısı : $dogruPuan'),
                          buildContainer('Kullanılan Pas Sayısı : $pasHakki'),
                          buildContainer('Tabuu Sayısı : $tabooPuan'),
                          buildContainer('Kazanılan Puan : $anlikpuan'),
                          buildContainer('Toplam Skor '),
                          sirakontrol % 2 == 0
                              ? buildContainer(takim1Skor.toString())
                              : buildContainer(takim2Skor.toString())
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'OYUN BİTTİ',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Divider(
                      height: 20,
                      indent: 500.0,
                    ),
                    Text(
                      '${takim1Name.text} takımı kazandı.',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                alignment: Alignment.center,
              ));
  }

  Container buildContainer(String bilgi) {
    return Container(
      color: Colors.blue[300],
      width: MediaQuery.of(context).size.width - 50,
      height: MediaQuery.of(context).size.height / 7 - 50,
      alignment: Alignment.center,
      child: Text(
        bilgi,
        style: TextStyle(
          decoration: bilgi == 'Toplam Skor'
              ? TextDecoration.underline
              : TextDecoration.none,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }
}
