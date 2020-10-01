import 'package:Taboo/baslamadan_once.dart';
import 'package:Taboo/oyun_ekrani.dart';
import 'package:Taboo/sonuc_ekrani.dart';
import 'package:Taboo/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:nice_button/NiceButton.dart';

bool control = false;
String text = '''
Oyunumuzdaki bütün kelimeler tükendi. 

''';

class GameOver extends StatefulWidget {
  @override
  _GameOverState createState() => _GameOverState();
}

class _GameOverState extends State<GameOver> {
  @override
  Widget build(BuildContext context) {
    final TodoHelper _todoHelper = TodoHelper();

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text(
              'Oyun Bitti',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          body: Container(
            color: Colors.white,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () async {
                      gonderilen = sirakontrol % 2 == 0
                          ? TaskModel(takim1: anlikpuan, takim2: 0)
                          : TaskModel(takim1: 0, takim2: anlikpuan);
                      await _todoHelper.insertTask(gonderilen);
                      await _todoHelper.calculateTotal();
                      setState(() {
                        takim1Skor = takim1Skor;
                        takim2Skor = takim2Skor;
                        print(takim1Skor);
                        print(takim2Skor);
                        control = true;
                      });
                    },
                    child: control == false
                        ? Text(
                            'Oyunun kazananını öğrenmek için TIKLAYIN',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline),
                          )
                        : Text(
                            'Oyunun Sonucu',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline),
                          ),
                  ),
                  control == false
                      ? Text('')
                      : takim1Skor > takim2Skor
                          ? Text(
                              'Kazanan : ' + takim1Name.text,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            )
                          : takim1Skor < takim2Skor
                              ? Text(
                                  'Kazanan : ' + takim2Name.text,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )
                              : Text(
                                  'Berabere',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )
                ],
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: NiceButton(
            onPressed: () => SystemNavigator.pop(),
            background: Colors.amber,
            radius: 40,
            padding: const EdgeInsets.all(15),
            text: "Çıkış Yap",
            icon: LineAwesomeIcons.door_closed,
            gradientColors: [
              Colors.blue,
              Colors.amber,
            ],
          )),
    );
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Emin Misiniz'),
            content: Text('Uygulama kapatılsın mı ?'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('Hayır'),
              ),
              FlatButton(
                onPressed: () => SystemNavigator.pop(),
                child: Text('Evet'),
              ),
            ],
          ),
        ) ??
        false;
  }
}
