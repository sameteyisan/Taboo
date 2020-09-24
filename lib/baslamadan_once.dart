import 'package:Taboo/oyun_ekrani.dart';
import 'package:Taboo/toplu_degisimler.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:nice_button/NiceButton.dart';

class BaslamadanOnce extends StatefulWidget {
  @override
  _BaslamadanOnceState createState() => _BaslamadanOnceState();
}

TextEditingController takim1Name = TextEditingController();
TextEditingController takim2Name = TextEditingController();
final FocusNode takim1Focus = FocusNode();
final FocusNode takim2Focus = FocusNode();
GlobalKey<ScaffoldState> _snackbarKey = new GlobalKey<ScaffoldState>();

class _BaslamadanOnceState extends State<BaslamadanOnce> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _snackbarKey,
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
              'Başlamadan Önce Lütfen',
              style: TextStyle(color: Colors.black),
            ),
            Text(
              'Takım Adlarını Girin.',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 100,
                  height: 70,
                  child: TextField(
                    focusNode: takim1Focus,
                    textInputAction: TextInputAction.next,
                    onSubmitted: (a) {
                      _focusGecis(context, takim1Focus, takim2Focus);
                    },
                    controller: takim1Name,
                    decoration: InputDecoration(
                        icon: teamIcon,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                              width: 0.5,
                            )),
                        hintText: 'Takım 1 ',
                        labelText: 'Takım 1'),
                  ),
                ),
                Text('')
              ],
            ),
            Divider(
              height: 20,
              indent: 500.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(''),
                Container(
                  width: MediaQuery.of(context).size.width - 100,
                  height: 70,
                  child: TextField(
                    focusNode: takim2Focus,
                    controller: takim2Name,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                        icon: teamIcon,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(width: 0.5)),
                        hintText: 'Takım 2',
                        labelText: 'Takım 2'),
                  ),
                ),
              ],
            ),
            Divider(
              height: 20,
              indent: 500.0,
            ),
            NiceButton(
              background: Colors.amber,
              radius: 40,
              padding: const EdgeInsets.all(15),
              text: "Oyunu Başlat",
              icon: LineAwesomeIcons.play,
              gradientColors: [
                Colors.red,
                Colors.green,
                Colors.amber,
                Colors.blue,
              ],
              onPressed: () {
                if (takim1Name.text.length == 0 ||
                    takim2Name.text.length == 0) {
                  _snackbarKey.currentState.showSnackBar(SnackBar(
                      duration: Duration(milliseconds: 500),
                      content: Row(
                        children: [
                          Icon(LineAwesomeIcons.exclamation),
                          Text(
                            'Takım adları boş bırakılamaz.',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      )));
                } else if (takim1Name.text.length > 12 ||
                    takim2Name.text.length > 12) {
                  _snackbarKey.currentState.showSnackBar(SnackBar(
                      duration: Duration(milliseconds: 500),
                      content: Row(
                        children: [
                          Icon(LineAwesomeIcons.exclamation),
                          Text(
                            'Takım adları 12 karakter büyük olamaz.',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      )));
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OyunEkrani()),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }

  _focusGecis(BuildContext context, FocusNode simdiki, FocusNode siradaki) {
    simdiki.unfocus();
    FocusScope.of(context).requestFocus(siradaki);
  }
}
