import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashcard/model/user.dart';

class FirebaseUserConverter {
  Future<User> convert(FirebaseUser user, {String displayName}) async {
    var idToken = await user.getIdToken();
    return User(displayName ?? user.displayName, user.email, idToken.token,
        idToken.authTime, idToken.issuedAtTime, idToken.expirationTime);
  }
}
