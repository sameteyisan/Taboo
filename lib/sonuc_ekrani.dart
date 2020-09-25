import 'package:Taboo/oyun_ekrani.dart';
import 'package:Taboo/sqflite.dart';
import 'package:Taboo/toplu_degisimler.dart';
import 'package:flutter/material.dart';
import 'package:nice_button/NiceButton.dart';

var takim1Skor = '';
var takim2Skor = '';
var sirakontrol = 0;
List<TaskModel> a = [];
TaskModel gonderilen;
final TodoHelper _todoHelper = TodoHelper();

class SonucEkrani extends StatefulWidget {
  @override
  _SonucEkraniState createState() => _SonucEkraniState();
}

class _SonucEkraniState extends State<SonucEkrani> {
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
      floatingActionButton: NiceButton(
        width: double.infinity,
        background: Colors.amber,
        radius: 40,
        padding: const EdgeInsets.all(15),
        text: "Sıradaki Takımdan Devam Et",
        fontSize: 15,
        icon: teamIcon.icon,
        gradientColors: [
          Colors.red,
          Colors.green,
          Colors.amber,
          Colors.blue,
        ],
        onPressed: () async {
          a = await _todoHelper.getAllTask();
          print(a.last.takim1);
          print(a.last.takim2);
          setState(() {
            takim1Skor = a.last.takim1.toString();
            takim2Skor = a.last.takim2.toString();
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
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                  border: Border.all(width: 0.5, color: Colors.black)),
              width: MediaQuery.of(context).size.width - 50,
              height: MediaQuery.of(context).size.height - 343,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        ),
                        border: Border.all(width: 0.5, color: Colors.black)),
                    width: MediaQuery.of(context).size.width - 50,
                    height: 70,
                    child: Text(
                      'Takım 1',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  buildContainer('Doğru Sayısı : $dogruPuan'),
                  buildContainer('Kullanılan Pas Sayısı : $pasHakki'),
                  buildContainer('Taboo Sayısı : $tabooPuan'),
                  buildContainer('Kazanılan Puan : $anlikpuan'),
                  buildContainer('Toplam Skor '),
                  sirakontrol % 2 == 0
                      ? buildContainer('${(takim1Skor + anlikpuan.toString())}')
                      : buildContainer('${(takim1Skor + anlikpuan.toString())}')
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildContainer(String bilgi) {
    return Container(
      color: Colors.blueAccent,
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
