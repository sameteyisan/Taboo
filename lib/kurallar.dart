import 'package:Taboo/toplu_degisimler.dart';
import 'package:flutter/material.dart';

String oyunaBasla = '''
Oyuna başlamak için buraya tıklanılır.
Oyuncular 2 takıma ayrılır.
Takım adları girilir.
Oyuncular her el değişmek üzere bir anlatıcı seçer.
Anlatıcı yasaklı olan 5 kelimeyi kullanmadan ana kelimeyi takım arkadaşlarına anlatmaya çalışır.
Eğer yasaklı kelimeler takım arkadaşları tarafından söylenirse, o kelimeyi anlatıcı artık kullanabilir.
Ancak anlatıcı, yasaklı olan kelimelerden birini takım arkadaşları tarafından söylenmeden kullanırsa Tabu olur ve tabuya basarak puanı düşürülür.
Her anlatılan kelimede için doğruya basılır ve ayarlanan puan toplam skora eklenir.
Oyun bitiş puanına ilk ulaşan veya geçen takım oyunun galibi olur.''';
String ayarlar = '''
Ayarlar üzerinde oynama yapmak için buraya tıklanılır.
Bu sekmede oyunun kaçta biteceği, her el anlatıcıya verilen süre, her anlatılan kelimenin kaç puan olacağı ve tabu puanı ayarlanır.
Eğer hiçbir ayar yapılmazsa orijinal ayarlar kullanılır.
Eğer ayarlar değiştirilirse ve orijinal ayarlara geri dönülmek istenilirse, başlangıç ayarlarına dön butonuna basılır.
''';
String cikisYap = '''
Oyun içinde oyundan çıkmak istenilirse buraya tıklanılır.
Oyundan çıkılır ve tüm ayarlar sıfırlanır.
''';

class NasilOynanir extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          splashRadius: 20,
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
              'Oyun Kuralları',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView(
          children: [
            buildContainer('Oyuna Başla'),
            buildDivider(),
            buildText(oyunaBasla),
            buildContainer('Ayarlar'),
            buildDivider(),
            buildText(ayarlar),
            buildContainer('Çıkış Yap'),
            buildDivider(),
            buildText(cikisYap),
          ],
        ),
      ),
    );
  }

  Divider buildDivider() {
    return Divider(
      height: 10,
      indent: 500.0,
    );
  }

  Text buildText(String text) => Text(
        text,
        style: TextStyle(fontSize: 18),
      );

  Container buildContainer(String baslik) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        baslik,
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
