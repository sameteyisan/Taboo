import 'package:Taboo/oyun_ekrani.dart';
import 'package:Taboo/toplu_degisimler.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:nice_button/NiceButton.dart';

class BaslamadanOnce extends StatefulWidget {
  @override
  _BaslamadanOnceState createState() => _BaslamadanOnceState();
}

TextEditingController takim1Name = TextEditingController(text: 'Takım1');
TextEditingController takim2Name = TextEditingController(text: 'Takım2');
final FocusNode takim1Focus = FocusNode();
final FocusNode takim2Focus = FocusNode();
GlobalKey<ScaffoldState> _snackbarKey = new GlobalKey<ScaffoldState>();

class _BaslamadanOnceState extends State<BaslamadanOnce> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        setState(() {
          takim1Name.text = 'Takım1';
          takim2Name.text = 'Takım2';
        });
        Navigator.pop(context);
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          key: _snackbarKey,
          appBar: AppBar(
            leading: IconButton(
              splashRadius: 20,
              icon: backButton,
              onPressed: () {
                setState(() {
                  takim1Name.text = 'Takım1';
                  takim2Name.text = 'Takım2';
                });
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
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 250,
                      width: 250,
                      child: Image.asset('asset/images/tabuu.png'),
                    ),
                    Divider(
                      height: 20,
                      indent: 500.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 100,
                          height: 70,
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                takim1Name = takim1Name;
                              });
                            },
                            focusNode: takim1Focus,
                            textInputAction: TextInputAction.next,
                            onSubmitted: (a) {
                              _focusGecis(context, takim1Focus, takim2Focus);
                            },
                            controller: takim1Name,
                            decoration: InputDecoration(
                                icon: teamIcon,
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    borderSide: BorderSide(
                                      width: 0.5,
                                    )),
                                hintText: 'Takım 1 ',
                                labelText: 'Takım 1'),
                          ),
                        ),
                        Text('  '),
                        buildAnimatedCrossFade(takim1Name.text),
                        Spacer(
                          flex: 1,
                        )
                      ],
                    ),
                    Divider(
                      height: 20,
                      indent: 500.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Spacer(
                          flex: 1,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 100,
                          height: 70,
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                takim2Name = takim2Name;
                              });
                            },
                            focusNode: takim2Focus,
                            controller: takim2Name,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                                icon: teamIcon,
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    borderSide: BorderSide(width: 0.5)),
                                hintText: 'Takım 2',
                                labelText: 'Takım 2'),
                          ),
                        ),
                        Text('  '),
                        buildAnimatedCrossFade(takim2Name.text),
                      ],
                    ),
                    Divider(
                      height: 20,
                      indent: 500.0,
                    ),
                    AnimatedCrossFade(
                        firstChild: NiceButton(
                            background: Colors.amber,
                            radius: 40,
                            padding: const EdgeInsets.all(15),
                            text: "Oyuna Başla",
                            icon: LineAwesomeIcons.play,
                            gradientColors: [
                              Colors.green,
                              Colors.blue,
                            ],
                            onPressed: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => OyunEkrani()),
                                  (Route<dynamic> route) => false);
                            }),
                        secondChild: NiceButton(
                          background: Colors.amber,
                          radius: 40,
                          padding: const EdgeInsets.all(15),
                          text: "Bilgileri Doldur",
                          icon: LineAwesomeIcons.exclamation,
                          gradientColors: [
                            Colors.black,
                            Colors.grey,
                          ],
                          onPressed: () {
                            Flushbar(
                              boxShadows: [
                                BoxShadow(
                                    color: Colors.white,
                                    offset: Offset(0.0, 2.0),
                                    blurRadius: 3.0)
                              ],
                              backgroundGradient: LinearGradient(
                                  colors: [Colors.black, Colors.black]),
                              flushbarPosition: FlushbarPosition.TOP,
                              title: 'Başarısız İşlem',
                              message: 'Bilgiler Eksik Girildi.',
                              duration: Duration(seconds: 1),
                            )..show(context);
                          },
                        ),
                        duration: const Duration(milliseconds: 500),
                        crossFadeState: takim1Name.text.length == 0 ||
                                takim2Name.text.length == 0 ||
                                takim1Name.text.length > 12 ||
                                takim2Name.text.length > 12
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  AnimatedCrossFade buildAnimatedCrossFade(String info) {
    return AnimatedCrossFade(
        duration: Duration(milliseconds: 500),
        firstChild: Icon(
          LineAwesomeIcons.check,
          color: Colors.green,
        ),
        secondChild: Icon(
          LineAwesomeIcons.exclamation,
          color: Colors.black,
        ),
        crossFadeState: info.length == 0 || info.length > 12
            ? CrossFadeState.showSecond
            : CrossFadeState.showFirst);
  }

  _focusGecis(BuildContext context, FocusNode simdiki, FocusNode siradaki) {
    simdiki.unfocus();
    FocusScope.of(context).requestFocus(siradaki);
  }
}
