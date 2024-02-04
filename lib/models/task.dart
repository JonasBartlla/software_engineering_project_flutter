class Task{

  String bezeichnung;
  String? notiz;
  String? zugehoerigeListe;
  String prioritaet;
  String? wiederholung;
  DateTime faelligkeitsdatum;
  bool benachrichtigung;
  String ownerId;
  DateTime creationDate;
  bool done;


  Task({required this.bezeichnung, this.notiz, this.zugehoerigeListe, required this.prioritaet, this.wiederholung, required this.faelligkeitsdatum, required this.benachrichtigung, required this.ownerId, required this.creationDate, required this.done});

}