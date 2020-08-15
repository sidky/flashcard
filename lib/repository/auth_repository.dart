import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashcard/converter/firebase_user_converter.dart';
import 'package:flashcard/model/auth_operation.dart';
import 'package:flashcard/model/auth_state.dart';
import 'package:flashcard/model/user.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/subjects.dart';

import '../model/auth_state.dart';

class AuthRepository {
  final FirebaseAuth _auth;
  final FirebaseUserConverter _converter;

  bool _isLoggedIn = false;
  User _loggedInUser;

  BehaviorSubject<AuthState> _authStateSubject = BehaviorSubject();

  AuthRepository({FirebaseAuth auth, FirebaseUserConverter converter})
      : this._auth = auth ?? GetIt.I.get(),
        this._converter = converter ?? GetIt.I.get() {
    _authStateSubject.add(AuthState.unauthenticated());
    this._auth.onAuthStateChanged.listen((event) {
      if (event != null) {
        event.getIdToken().then((value) {
          this._loggedInUser = User(event.displayName, event.email, value.token,
              value.authTime, value.issuedAtTime, value.expirationTime);
          this._isLoggedIn = true;
          _authStateSubject.add(AuthState(this._loggedInUser, DateTime.now()));
        }).catchError((e) {
          print(e);
          _auth.signOut().then((value) => print("Successfully signed out"));
        });
      }
    });
  }

  Future<AuthState> get currentAuthState =>
      _auth.currentUser().then((firebaseUser) async {
        if (firebaseUser != null) {
          var user = await _converter.convert(firebaseUser);
          return AuthState(user, DateTime.now());
        } else {
          return AuthState.unauthenticated();
        }
      });

  bool get isLoggedIn => _isLoggedIn;
  User get loggedInUser => _loggedInUser;

  Stream<AuthState> get authState => _authStateSubject.stream;

  Future<AuthOperation> registerNewUser(
      String name, String email, String password) async {
    try {
      var result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      UserUpdateInfo update = UserUpdateInfo();
      update.displayName = name;
      await result.user.updateProfile(update);

      return _successful(
          await _converter.convert(result.user, displayName: name));
    } on PlatformException catch (e) {
      return _failure(e.message);
    }
  }

  Future<AuthOperation> login(String email, String password) async {
    try {
      var result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      return _successful(await _converter.convert(result.user));
    } on PlatformException catch (e) {
      return _failure(e.message);
    }
  }

  AuthOperation _successful(User user) =>
      AuthOperation(user, null, user.authTime);
  AuthOperation _failure(String error) =>
      AuthOperation(null, error, DateTime.now());
}
