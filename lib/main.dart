import 'package:Taboo/ayarlar.dart';
import 'package:Taboo/baslamadan_once.dart';
import 'package:Taboo/kurallar.dart';
import 'package:Taboo/sqflite.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tabuu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
        body: ListView(
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width - 92.7,
                height: MediaQuery.of(context).size.height / 2.7 + 2.4,
                child: Image.asset('asset/images/tabuu.png'),
              ),
              buildDivider(context),
              buildGestureDetector(
                context,
                'Oyuna Başla',
                Icon(
                  LineAwesomeIcons.play,
                  color: Colors.white,
                ),
              ),
              buildDivider(context),
              buildGestureDetector(
                context,
                'Ayarlar',
                Icon(
                  LineAwesomeIcons.stream,
                  color: Colors.white,
                ),
              ),
              buildDivider(context),
              buildGestureDetector(
                context,
                'Kurallar',
                Icon(
                  LineAwesomeIcons.info,
                  color: Colors.white,
                ),
              ),
              buildDivider(context),
              buildGestureDetector(
                context,
                'Çıkış Yap',
                Icon(
                  LineAwesomeIcons.door_closed,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }

  Divider buildDivider(BuildContext context) {
    return Divider(
      height: MediaQuery.of(context).size.height / 40,
      indent: 500.0,
    );
  }

  GestureDetector buildGestureDetector(
      BuildContext context, String text, dynamic iconn) {
    final TodoHelper _todoHelper = TodoHelper();

    return GestureDetector(
      onTap: () {
        text == 'Oyuna Başla'
            ? Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BaslamadanOnce()),
              )
            : text == 'Ayarlar'
                ? Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Ayarlar()),
                  )
                : text == 'Kurallar'
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NasilOynanir()),
                      )
                    : SystemNavigator.pop();
        _todoHelper.delete();
      },
      child: Container(
          width: MediaQuery.of(context).size.width / 1.5,
          height: 60,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              )
            ],
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.blue[300],
          ),
          alignment: Alignment.center,
          child: ListTile(
            leading: iconn,
            title: Text(
              text,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          )),
    );
  }
}
