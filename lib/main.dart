import 'package:Taboo/ayarlar.dart';
import 'package:Taboo/baslamadan_once.dart';
import 'package:Taboo/nas%C4%B1l_oynan%C4%B1r.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Taboo',
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
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('asset/images/background.jpg'),
                fit: BoxFit.cover)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildContainer(Colors.red, 'Oyuna', 'Başla'),
                  buildContainer(Colors.green, 'Nasıl', 'Oynanır ?'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildContainer(Colors.amber, 'Ayarlar', ''),
                  GestureDetector(
                    onTap: () => SystemNavigator.pop(),
                    child: Container(
                        alignment: Alignment.center,
                        width: (MediaQuery.of(context).size.width / 2) - 30,
                        height: (MediaQuery.of(context).size.width / 2) - 30,
                        color: Colors.blue,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Çıkış',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            Text(
                              'Yap',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ],
                        )),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector buildContainer(a, String text, String text2) {
    return GestureDetector(
      onTap: () {
        if (text == 'Oyuna') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BaslamadanOnce()),
          );
        } else if (text == 'Nasıl') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NasilOynanir()),
          );
        } else if (text == 'Ayarlar') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Ayarlar()),
          );
        }
      },
      child: Container(
          alignment: Alignment.center,
          width: (MediaQuery.of(context).size.width / 2) - 30,
          height: (MediaQuery.of(context).size.width / 2) - 30,
          color: a,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              Text(
                text2,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ],
          )),
    );
  }
}
