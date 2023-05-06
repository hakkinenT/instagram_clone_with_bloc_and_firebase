import 'package:flutter/foundation.dart';
import 'package:school_management/data/service/response/response.dart';

abstract class FileStorageService {
  Future<Response> uploadImageToStorage(
      String childName, Uint8List photoFile, bool isPost);
}
