abstract class AppException {
  final dynamic code;
  final String? message;

  const AppException({this.code = 'unknown', this.message});
}

class AuthenticationException extends AppException {
  const AuthenticationException({super.code, super.message});
}

class FileStorageException extends AppException {
  const FileStorageException({super.code, super.message});
}

class DatastoreException extends AppException {
  const DatastoreException({super.code, super.message});
}
