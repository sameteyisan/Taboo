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
    "kelime": "kadın budu",
    "yasakli": ["kelime1", "kelime2", "kelime3", "kelime4", "kelime5"],
  },
  {
    "kelime": "kadın",
    "yasakli": ["kelime1", "kelime2", "kelime3", "kelime4", "kelime5"],
  },
  {
    "kelime": "but",
    "yasakli": ["kelime1", "kelime2", "kelime3", "kelime4", "kelime5"],
  }
];
