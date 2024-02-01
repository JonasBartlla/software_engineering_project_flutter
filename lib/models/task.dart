class Task{

  String bezeichnung;
  String? notiz;
  String? zugehoerigeListe;
  String prioritaet;
  String? wiederholung;
  DateTime faelligkeitsdatum;
  String ownerId;
  DateTime creationDate;

  Task({required this.bezeichnung, this.notiz, this.zugehoerigeListe, required this.prioritaet, this.wiederholung, required this.faelligkeitsdatum, required this.ownerId, required this.creationDate});

}