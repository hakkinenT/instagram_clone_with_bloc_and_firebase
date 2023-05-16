import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:uuid/uuid.dart';

import '../../../core/error/exceptions.dart';
import '../interfaces/file_storage_service.dart';
import '../response/response.dart';

class FileStorageServiceImpl implements FileStorageService {
  final FirebaseStorage storage;

  const FileStorageServiceImpl({required this.storage});

  @override
  Future<Response> uploadImageToStorage(
      String childName, Uint8List photoFile, bool isPost) async {
    try {
      Reference ref = storage
          .ref()
          .child(childName)
          .child(FirebaseAuth.instance.currentUser!.uid);

      if (isPost) {
        String id = const Uuid().v1();
        ref = ref.child(id);
      }

      UploadTask uploadTask = ref.putData(photoFile);

      TaskSnapshot snap = await uploadTask;
      String downloadUrl = await snap.ref.getDownloadURL();
      return Response(data: downloadUrl);
    } on FirebaseException catch (e) {
      throw FileStorageException(code: e.code);
    } catch (_) {
      throw const FileStorageException();
    }
  }
}
