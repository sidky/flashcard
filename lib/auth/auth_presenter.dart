import 'dart:async';

import 'package:flashcard/model/auth_state.dart';
import 'package:flashcard/repository/auth_repository.dart';
import 'package:get_it/get_it.dart';

enum AuthScreen {
  login,
  signup,
}

class AuthPresenter {
  final AuthRepository _repository;

  final StreamController<AuthScreen> _selectScreenStream =
      StreamController.broadcast();

  bool _isBusy = false;

  AuthPresenter({AuthRepository repository})
      : this._repository = repository ?? GetIt.I.get() {
    _selectScreenStream.add(AuthScreen.login);
  }

  Stream<AuthScreen> get screenState => this._selectScreenStream.stream;

  Future<AuthState> register(
      String displayName, String email, String password) async {
    var result =
        await _repository.registerNewUser(displayName, email, password);

    if (!result.isSuccessful()) {
      print(result.error);
    }
    AuthState state = AuthState(
        result.isSuccessful() ? result.user : null, result.operationTime);
    return state;
  }

  Future<AuthState> login(String email, String password) async {
    var result = await _repository.login(email, password);

    if (!result.isSuccessful()) {
      print(result.error);
    }
    AuthState state = AuthState(
        result.isSuccessful() ? result.user : null, result.operationTime);
    return state;
  }

  void switchScreen(AuthScreen screen) {
    _selectScreenStream.add(screen);
  }
}
