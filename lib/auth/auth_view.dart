import 'dart:async';

import 'package:flashcard/auth/auth_presenter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../repository/auth_repository.dart';

class AuthView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AuthViewState();
}

class _AuthViewState extends State {
  final AuthPresenter _presenter;
  bool _loginScreen = true;

  StreamSubscription _subscription;

  _AuthViewState({AuthPresenter presenter})
      : _presenter = presenter ?? GetIt.I.get() {
    this._subscription = _presenter.screenState.listen((event) {
      setState(() {
        this._loginScreen = event == AuthScreen.login;
      });
    });

    _presenter.authState.listen((event) {
      if (event.isAuthenticated()) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _loginScreen ? _LoginView() : _SignupView(),
    );
  }

  @override
  void dispose() {
    super.dispose();

    if (_subscription != null) {
      _subscription.cancel();
    }
  }
}

class _SignupView extends StatelessWidget {
  final AuthPresenter _presenter;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  _SignupView({AuthPresenter presenter})
      : _presenter = presenter ?? GetIt.I.get();

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 300,
          maxWidth: 300,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Register new user"),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: "Password"),
            ),
            FlatButton(
                onPressed: () => _presenter.register(_nameController.text,
                    _emailController.text, _passwordController.text),
                color: Colors.blue,
                splashColor: Colors.blueAccent,
                child: Text("Signup")),
            Center(
                child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FlatButton(
                    onPressed: () => _presenter.switchScreen(AuthScreen.login),
                    color: Colors.transparent,
                    child: Text("Already have an account",
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3)),
              ],
            ))
          ],
        ));
  }
}

class _LoginView extends StatelessWidget {
  final AuthPresenter _presenter;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  _LoginView({AuthPresenter presenter})
      : _presenter = presenter ?? GetIt.I.get();

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: 300,
        maxWidth: 300,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Login"),
          TextField(
            controller: _emailController,
            decoration: InputDecoration(labelText: "Email"),
          ),
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(labelText: "Password"),
          ),
          FlatButton(
              onPressed: () => _presenter.login(
                  _emailController.text, _passwordController.text),
              color: Colors.blue,
              splashColor: Colors.blueAccent,
              child: Text("Login")),
          Center(
              child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FlatButton(
                  onPressed: null,
                  color: Colors.grey,
                  child: Text(
                    "Forgot password",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  )),
              FlatButton(
                  onPressed: () => _presenter.switchScreen(AuthScreen.signup),
                  color: Colors.transparent,
                  child: Text("Create New",
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3)),
            ],
          ))
        ],
      ),
    );
  }
}
