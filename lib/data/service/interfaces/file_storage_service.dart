import 'package:flutter/foundation.dart';

import '../response/response.dart';

abstract class FileStorageService {
  Future<Response> uploadImageToStorage(
      String childName, Uint8List photoFile, bool isPost);
}
