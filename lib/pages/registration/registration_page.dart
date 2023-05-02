import 'package:flutter/material.dart';
import 'package:messenger/services/navigation_service.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  late double _deviceHeight;
  late double _deviceWight;

  late GlobalKey<FormState> _formKey;

  String _name = '';
  String _email = '';
  String _password = '';

  _RegistrationPageState() {
    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWight = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Container(
          alignment: Alignment.center,
          child: registrationPageUI(),
        ));
  }

  Widget registrationPageUI() {
    return Container(
      height: _deviceHeight * 0.75,
      padding: EdgeInsets.symmetric(horizontal: _deviceWight * 0.10),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _headingWidget(),
            _inputForm(),
          ]),
    );
  }

  Widget _headingWidget() {
    return Container(
      height: _deviceHeight * 0.12,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text(
            "Let's get going!",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
          ),
          Text(
            "Please enter your details.",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w200),
          )
        ],
      ),
    );
  }

  Widget _inputForm() {
    return Container(
      height: _deviceHeight * 0.55,
      child: Form(
          key: _formKey,
          onChanged: () {
            _formKey.currentState!.save();
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _imageSelectorWidget(),
              _nameTextField(),
              _emailTextField(),
              _passwordTextField(),
              _registerButton(),
              _backToLoginPageButton(),
            ],
          )),
    );
  }

  Widget _imageSelectorWidget() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: _deviceHeight * 0.10,
        width: _deviceWight * 0.10,
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(500),
            image: const DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                  "https://p7.hiclipart.com/preview/633/901/253/social-media-computer-icons-facebook-messenger-black-facebook-messenger-logo.jpg"),
            )),
      ),
    );
  }

  Widget _nameTextField() {
    return TextFormField(
      autocorrect: false,
      style: const TextStyle(color: Colors.white),
      validator: (_input) {
        return _input!.isNotEmpty ? null : "Please enter a valid email.";
      },
      onSaved: (_input) {
        setState(() {
          _name = _input!;
        });
      },
      cursorColor: Colors.white,
      decoration: const InputDecoration(
          hintText: "Name",
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white))),
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

  Widget _registerButton() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: _deviceHeight * 0.06,
      width: _deviceWight,
      child: MaterialButton(
        onPressed: () {},
        color: Colors.blue,
        child: const Text(
          "Register",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  Widget _backToLoginPageButton() {
    return GestureDetector(
      onTap: () {
        NavigationService.instance.goBack();
      },
      child: Container(
        height: _deviceHeight * 0.06,
        width: _deviceWight,
        child: Icon(
          Icons.arrow_back,
          size: 40,
        ),
      ),
    );
  }
}
