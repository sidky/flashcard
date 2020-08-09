import 'package:flashcard/model/user.dart';

class AuthState {
  final User user;
  final DateTime updatedAt;

  AuthState(this.user, this.updatedAt);

  AuthState.unauthenticated()
      : user = null,
        updatedAt = DateTime.now();

  bool isAuthenticated() => user != null;
}
