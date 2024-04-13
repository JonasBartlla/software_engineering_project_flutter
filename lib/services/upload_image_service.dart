import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;
class UploadImageService{
  Future<String> uploadImageToStorage(String fileName, Uint8List file) async{
    Reference ref = _storage.ref().child('${fileName}_profilepic');
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String dowloadUrl = await snapshot.ref.getDownloadURL();
    return dowloadUrl;
  }
}