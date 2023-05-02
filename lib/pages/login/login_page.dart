import 'package:flutter/material.dart';
import 'package:messenger/services/navigation_service.dart';
import 'package:messenger/services/snackbar_service.dart';
import 'package:provider/provider.dart';
import 'package:messenger/providers/auth_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late double _deviceHeight;
  late double _deviceWight;

  late GlobalKey<FormState> _formKey;
  late AuthProvider _auth;

  String _email = '';
  String _password = '';

  _LoginPageState() {
    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWight = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Align(
        alignment: Alignment.center,
        child: ChangeNotifierProvider<AuthProvider>.value(
          value: AuthProvider.instance,
          child: _loginPageUI(),
        ),
      ),
    );
  }

  Widget _loginPageUI() {
    return Builder(builder: (BuildContext _context) {
      _auth = Provider.of<AuthProvider>(_context);
      SnackbarService.instance.buildContext = context;
      return Container(
        padding: EdgeInsets.symmetric(horizontal: _deviceWight * 0.10),
        height: _deviceHeight * 0.60,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _headWidget(),
            _inputForm(),
          ],
        ),
      );
    });
  }

  Widget _headWidget() {
    return Container(
      height: _deviceHeight * 0.12,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text(
            "Welcome back!",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
          ),
          Text(
            "Please login to your account.",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
          )
        ],
      ),
    );
  }

  Widget _inputForm() {
    return Container(
      height: _deviceHeight * 0.35,
      child: Form(
          key: _formKey,
          onChanged: () {
            _formKey.currentState!.save();
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              _emailTextField(),
              _passwordTextField(),
              _loginButton(),
              _registerButton(),
            ],
          )),
    );
  }

  Widget _emailTextField() {
    return TextFormField(
      autocorrect: false,
      style: const TextStyle(color: Colors.white),
      validator: (_input) {
        return _input!.isNotEmpty && _input.contains("@")
            ? null
            : "Please enter a valid email.";
      },
      onSaved: (_input) {
        setState(() {
          _email = _input!;
        });
      },
      cursorColor: Colors.white,
      decoration: const InputDecoration(
          hintText: "Email address",
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white))),
    );
  }

  Widget _passwordTextField() {
    return TextFormField(
      autocorrect: false,
      obscureText: true,
      style: const TextStyle(
        color: Colors.white,
      ),
      validator: (_input) {
        return _input!.isNotEmpty ? null : "Please enter a password.";
      },
      onSaved: (_input) {
        setState(() {
          _password = _input!;
        });
      },
      cursorColor: Colors.white,
      decoration: const InputDecoration(
          hintText: "Password",
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white))),
    );
  }

  Widget _loginButton() {
    return _auth.status == AuthStatus.authenticating
        ? Align(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          )
        : Container(
            margin: const EdgeInsets.only(top: 10),
            height: _deviceHeight * 0.06,
            width: _deviceWight,
            child: MaterialButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _auth.loginUserWithEmailAndPassword(_email, _password);
                }
              },
              color: Colors.blue,
              child: const Text(
                "LOGIN",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
              ),
            ),
          );
  }

  Widget _registerButton() {
    return GestureDetector(
      child: Container(
        height: _deviceHeight * 0.06,
        width: _deviceWight,
        child: MaterialButton(
          onPressed: () {
            NavigationService.instance.navigateTo("register");
          },
          child: const Text(
            "REGISTER",
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Colors.white60),
          ),
        ),
      ),
    );
  }
}
