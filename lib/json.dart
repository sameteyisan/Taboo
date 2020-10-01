class Tabu {
  String kelime;
  List<String> yasakli;

  Tabu(this.kelime, this.yasakli);

  factory Tabu.fromJson(List<dynamic> tabuJson, int random) {
    var t = tabuJson[random];
    return Tabu(t['kelime'] as String, t['yasakli'] as List<String>);
  }

  @override
  String toString() {
    return '{ ${this.kelime}, ${this.yasakli} }';
  }
}

var tabu = [
  {
    "kelime": "HECE",
    "yasakli": ["Kelime", "Harf", "Ses", "Okumak", "Yazı"],
  },
  {
    "kelime": "KÜSMEK",
    "yasakli": ["Darılmak", "Kızmak", "Konuşmak", "Tartışmak", "Kavga"],
  },
  {
    "kelime": "AVİZE",
    "yasakli": ["Lamba", "Kristal", "Tavan", "Işık", "Aydınlık"],
  },
  {
    "kelime": "KOORDİNAT",
    "yasakli": ["Yer", "Enlem", "Boylam", "Belirtmek", "Vermek"],
  },
  {
    "kelime": "TERİM",
    "yasakli": ["Kelime", "Anlam", "Fatih", "Sanat", "Kavram"],
  },
  {
    "kelime": "SOYUT",
    "yasakli": ["Duyu", "Algılamak", "Görülmeyen", "İsim", "Somut"],
  },
  {
    "kelime": "BASKÜL",
    "yasakli": ["Tartı", "Kilo", "Ağır", "Ölçü", "Hafif"],
  },
  {
    "kelime": "HALÜSİNASYON",
    "yasakli": ["Hayal", "Gerçek", "Görmek", "İllüzyon", "Serap"],
  },
  {
    "kelime": "ARMAĞAN",
    "yasakli": ["Hediye", "Vermek", "Almak", "Doğum günü", "Sevindirmek"],
  },
  {
    "kelime": "ANTİKA",
    "yasakli": ["Müzayede", "Zengin", "Eski", "Tablo", "Tarihi"],
  },
  {
    "kelime": "ADEM ELMASI",
    "yasakli": ["Erkek", "Gırtlak", "Çıkıntı", "Boğaz", "Havva"],
  },
  {
    "kelime": "SATRANÇ",
    "yasakli": ["Şah-Mat", "Kale", "Vezir", "Piyon", "Fil"],
  },
  {
    "kelime": "PARAŞÜT",
    "yasakli": ["Uçak", "Atlamak", "Uçmak", "Balon", "Hava"],
  },
  {
    "kelime": "TİYATRO",
    "yasakli": ["Oyuncu", "Sahne", "Perde", "Oyun", "Suflör"],
  },
  {
    "kelime": "DOST",
    "yasakli": ["Güven", "Samimi", "Dürüst", "Arkadaş", "Ahlaklı"],
  },
  {
    "kelime": "ANAHTAR",
    "yasakli": ["Kilit", "Metal", "Kasa", "Kapı", "Çilingir"],
  }
];
