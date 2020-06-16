import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scoped_model/scoped_model.dart';
//import 'package:testapp1/pages/homepage_page.dart';
import 'package:testapp1/services/main_service.dart';
import '../style/mystrings.dart';

class AuthenticatePage extends StatefulWidget {
  static const String id = 'AuthPage';

  @override
  _AuthenticatePageState createState() => _AuthenticatePageState();
}

class _AuthenticatePageState extends State<AuthenticatePage> {
  String _email, _username, _password;
  bool _isToggleVisibility = true;
  bool _isLogin = true;
  bool _isLoading = false;

  GlobalKey<FormState> _globalFormKey = GlobalKey();

  Future _submit(BuildContext context, MainService model) async {
    //bool status = false;
    dynamic response = '';
    try {
      setState(() {
        _isLoading = true;
      });
      if (_globalFormKey.currentState.validate()) {
        _globalFormKey.currentState.save();
        print(_email);
        print(_password);
        print('_isLogin: $_isLogin');
        if (!_isLogin) {
          //print('_isLogin: $_isLogin');
          response = await model.mySignUp(_email, _password, _username);
        }
        if (_isLogin) {
          response = await model.mySignIn(_email, _password);
        }

        print(response);
        // setState(() {
        //   _isLoading = false;
        // });
      }
    } catch (e) {
      print(e.toString());
        // setState(() {
        //   _isLoading = false;
        // });
    }
  }

  @override
  void didChangeDependencies() {
      super.didChangeDependencies();
       setState(() {
          _isLoading = false;
        });

  }

  @override
  Widget build(BuildContext context) {
    return _isLoading?
    SpinKitCubeGrid(color: Colors.red,size: 70.0,duration: Duration(milliseconds: 900),):
     SafeArea(
        child: GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: ScopedModelDescendant<MainService>(
        builder: (BuildContext context, Widget child, MainService model) {
          return Scaffold(
            backgroundColor: Colors.red,
            resizeToAvoidBottomPadding: false,
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 140.0),
                  Center(
                    child: Text(appTitle,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(height: 30.0),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Form(
                        key: _globalFormKey,
                        child: Column(
                          children: <Widget>[
                            _isLogin
                                ? Card(
                                    elevation: 0.0,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 40.0, vertical: 40.0),
                                      child: Column(
                                        children: <Widget>[
                                          _buildUserNameEmailTextField('Email'),
                                          _buildPasswordTextField('Password'),
                                        ],
                                      ),
                                    ),
                                  )
                                : Card(
                                    elevation: 0.0,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 40.0, vertical: 40.0),
                                      child: Column(
                                        children: <Widget>[
                                          _buildUserNameField('Username'),
                                          _buildUserNameEmailTextField('Email'),
                                          _buildPasswordTextField('Password'),
                                        ],
                                      ),
                                    ),
                                  ),
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isLogin = !_isLogin;
                                  });
                                },
                                child: _isLogin
                                    ? _buildQuestion(
                                        'Not a user yet?', 'Sign Up')
                                    : _buildQuestion(
                                        'Already a user?', 'Log in')),
                            SizedBox(height: 50.0),
                            _isLogin
                                ? _buildButton(context, 'Login', model)
                                : _buildButton(context, 'Sign Up', model),
                          ],
                        )),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ));
  }

  Widget _buildUserNameEmailTextField(String text) {
    return TextFormField(
        decoration: InputDecoration(
          labelText: '$text',
          labelStyle: TextStyle(fontSize: 12),
        ),
        onSaved: (input) => _email = input.trim(),
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter email id';
          }
          if (!(value.contains('@'))) {
            return 'Invalid Email Id';
          }
        });
  }

  Widget _buildUserNameField(String text) {
    return TextFormField(
        decoration: InputDecoration(
          labelText: '$text',
          labelStyle: TextStyle(fontSize: 12),
        ),
        onSaved: (input) => _username = input.trim(),
        validator: (value) =>
            (value.isEmpty) ? 'Please enter a username' : null);
  }

  Widget _buildPasswordTextField(String text) {
    return TextFormField(
        decoration: InputDecoration(
          suffixIcon: IconButton(
              icon: _isToggleVisibility
                  ? Icon(Icons.visibility_off)
                  : Icon(Icons.visibility),
              onPressed: () {
                setState(() {
                  _isToggleVisibility = !_isToggleVisibility;
                });
              }),
          labelText: '$text',
          labelStyle: TextStyle(fontSize: 12),
        ),
        obscureText: _isToggleVisibility,
        onSaved: (value) => _password = value.trim(),
        validator: (value) {
          if (value.isEmpty) {
            return 'Password is empty';
          }
          if (value.length < 6) {
            return 'Length less than 6 characters';
          }
        });
  }

  Widget _buildButton(BuildContext context, text, MainService model) {
    return GestureDetector(
      onTap: () async {
        await _submit(context, model);
      },
      child: Container(
        height: 60.0,
        width: MediaQuery.of(context).size.width - 70,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0), color: Colors.white),
        child: Center(
            child: Text(
          '$text',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        )),
      ),
    );
  }

  Widget _buildQuestion(String text1, String text2) {
    return Container(
      padding: EdgeInsets.only(right: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            '$text1',
            style: TextStyle(fontSize: 10.0, color: Colors.white70),
          ),
          SizedBox(width: 10.0),
          Text(
            '$text2',
            style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ],
      ),
    );
  }
}
