class Task{

  String bezeichnung;
  String? notiz;
  String? zugehoerigeListe;
  String prioritaet;
  String? wiederholung;
  DateTime faelligkeitsdatum;

  Task({required this.bezeichnung, this.notiz, this.zugehoerigeListe, required this.prioritaet, this.wiederholung, required this.faelligkeitsdatum});

}