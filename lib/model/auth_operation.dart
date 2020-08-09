import 'package:flashcard/model/user.dart';

class AuthOperation {
  final User user;
  final String error;
  final DateTime operationTime;

  AuthOperation(this.user, this.error, this.operationTime);

  bool isSuccessful() => error == null && user != null;
}
