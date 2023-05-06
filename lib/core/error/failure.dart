import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure([this.message = 'Ocorreu um erro desconhecido.']);

  @override
  List<Object?> get props => [message];
}

class AuthenticationFailure extends Failure {
  const AuthenticationFailure([super.message]);

  factory AuthenticationFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const AuthenticationFailure(
            'O e-mail não é válido ou está mal formatado.');
      case 'user-disabled':
        return const AuthenticationFailure(
          'Este usuário foi desativado. Entre em contato com o suporte para obter ajuda.',
        );
      case 'email-already-in-use':
        return const AuthenticationFailure(
            'Já existe uma conta para esse e-mail.');
      case 'operation-not-allowed':
        return const AuthenticationFailure(
            'A operação não é permitida. Entre em contato com o suporte.');
      case 'weak-password':
        return const AuthenticationFailure('Digite uma senha mais forte.');
      case 'user-not-found':
        return const AuthenticationFailure(
            'E-mail não encontrado, por favor crie uma conta.');
      case 'wrong-password':
        return const AuthenticationFailure(
            'Senha incorreta.Por favor tente novamente.');
      case 'account-exists-with-different-credential':
        return const AuthenticationFailure(
            'A conta existe com credenciais diferentes.');
      case 'invalid-credential':
        return const AuthenticationFailure(
            'A credencial recebida está incorreta ou expirou.');
      case 'invalid-verification-code':
        return const AuthenticationFailure(
            'O código de verificação de credencial recebido é inválido.');
      case 'invalid-verification-id':
        return const AuthenticationFailure(
            'A ID de verificação de credencial recebida é inválida.');
      default:
        return const AuthenticationFailure();
    }
  }
}

class FileStorageFailure extends Failure {
  const FileStorageFailure([super.message]);

  factory FileStorageFailure.fromCode(String code) {
    switch (code) {
      case 'unknown':
        return const FileStorageFailure();
      case 'object-not-found':
        return const FileStorageFailure(
            'Não existe nenhum objeto na referência desejada.');
      case 'bucket-not-found':
        return const FileStorageFailure(
            'Não existe nenhum bucket configurado.');
      case 'project-not-found':
        return const FileStorageFailure(
            'Não existe nenhum projeto configurado.');
      case 'quota-exceeded':
        return const FileStorageFailure('A cota do bucket foi excedida.');
      case 'unauthenticated':
        return const FileStorageFailure('É necessário se autenticar.');
      case 'unauthorized':
        return const FileStorageFailure(
            'Não existe autorização para executar essa ação.');
      case 'limit-exceeded':
        return const FileStorageFailure(
            'O limite máximo de tempo da operação foi excedido. Envie novamente.');
      case 'invalid-checksum':
        return const FileStorageFailure(
          'O arquivo não corresponde à soma de verificação do arquivo recebido pelo servidor. Envie novamente.',
        );
      case 'canceled':
        return const FileStorageFailure('A operação foi cancelada.');
      case 'invalid-event-name':
        return const FileStorageFailure('O evento possui o nome inválido.');
      case 'invalid-url':
        return const FileStorageFailure('A URL fornecida é inválida.');
      case 'invalid-argument':
        return const FileStorageFailure(
            'O argumento passado ao put() é inválido.');
      case 'default-bucket':
        return const FileStorageFailure(
            'Nenhum bucket foi definido como default.');
      case 'cannot-slice-blob':
        return const FileStorageFailure(
            'O arquivo não pode ser alterado. Tente novamente.');
      case 'server-file-wrong-size':
        return const FileStorageFailure(
            'O arquivo não corresponde ao tamanho do arquivo no servidor. Envie novamente.');
      default:
        return const FileStorageFailure();
    }
  }
}

class DatastoreFailure extends Failure {
  const DatastoreFailure([super.message]);

  factory DatastoreFailure.fromCode(String code) {
    switch (code) {
      case 'aborted':
        return const DatastoreFailure('Operação abortada.');
      case 'already-exists':
        return const DatastoreFailure('O documento já existe.');
      case 'canceled':
        return const DatastoreFailure('A operação foi cancelada.');
      case 'data-loss':
        return const DatastoreFailure(
            'O dado foi perdido ou está corrompido. Envie novamente.');
      case 'deadline-exceeded':
        return const DatastoreFailure(
            'O prazo expirou antes da operação ser concluída. Tente novamente.');
      case 'failed-precondition':
        return const DatastoreFailure(
            'A operação foi rejeitada devido ao estado atual do sistema.');
      case 'internal':
        return const DatastoreFailure('Ocorreu um erro interno.');
      case 'invalid-argument':
        return const DatastoreFailure('Argumento inválido.');
      case 'not-found':
        return const DatastoreFailure(
            'O documento requisitado não foi encontrado.');
      case 'out-of-range':
        return const DatastoreFailure(
            'O intervalo válido para a execução da tarefa foi excedido.');
      case 'permission-denied':
        return const DatastoreFailure(
            'É necessário permissão para a execução dessa operação.');
      case 'resource-exhausted':
        return const DatastoreFailure(
            'Não há espaço para alocação do recurso.');
      case 'unauthenticated':
        return const DatastoreFailure(
            'A solicitação não possui credenciais de autenticação válidas para a operação.');
      case 'unavailable':
        return const DatastoreFailure(
            'O serviço está temporariamente indisponível.');
      case 'unimplemented':
        return const DatastoreFailure(
            'A operação não foi implementada ou não é suportada.');
      case 'unknown':
        return const DatastoreFailure();
      default:
        return const DatastoreFailure();
    }
  }
}
