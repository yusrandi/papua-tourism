import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:papua_tourism/bloc/auth_bloc/authentication_bloc.dart';
import 'package:papua_tourism/bloc/tourism_bloc/tourism_bloc.dart';
import 'package:papua_tourism/config/shared_info.dart';
import 'package:papua_tourism/res/images.dart';
import 'package:papua_tourism/res/strings.dart';
import 'package:papua_tourism/res/styling.dart';
import 'package:papua_tourism/ui/constant/constant.dart';
import 'package:papua_tourism/ui/screens/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweetalert/sweetalert.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  int _pageState = 0;
  var _backGroundColor = AppTheme.appBackgroundColor;

  double _windowWidth = 0.0;
  double _windowHeight = 0.0;

  double _loginYOffset = 0.0;
  double _lregisterYOffset = 0.0;

  double _loginOpacity = 1;

  double _headingTop = 100;

  double _registerHeight = 0;
  double _loginHeight = 0;

  bool keyboardVisibility = false;

  AuthenticationBloc _authenticationBloc;

  final _userEmail = new TextEditingController();
  final _userPass = new TextEditingController();
  final _userName = new TextEditingController();

  SharedInfo _sharedInfo;

  @override
  void initState() {
    super.initState();

    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    _authenticationBloc.add(CheckLoginEvent());
    _sharedInfo = SharedInfo();

    var keyboardVisibilityController = KeyboardVisibilityController();
    // Query
    print(
        'Keyboard visibility direct query: ${keyboardVisibilityController.isVisible}');

    // Subscribe
    keyboardVisibilityController.onChange.listen((bool visible) {
      print('Keyboard visibility update. Is visible: ${visible}');
      keyboardVisibility = visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    _windowHeight = deviceHeight(context);
    _windowWidth = deviceWith(context);

    _registerHeight = _windowHeight - 250;
    _loginHeight = _windowHeight - (_windowHeight / 2);

    switch (_pageState) {
      case 0:
        _backGroundColor = AppTheme.appBackgroundColor;
        _loginYOffset = _windowHeight;
        _loginHeight = keyboardVisibility
            ? _windowHeight
            : _windowHeight - (_windowHeight / 2);

        _lregisterYOffset = _windowHeight;

        _loginOpacity = 1;

        _headingTop = 100;
        break;
      case 1:
        _backGroundColor = AppTheme.topBarBackgroundColor;
        _loginYOffset = keyboardVisibility ? 30 : (_windowHeight / 2);
        _loginHeight = keyboardVisibility
            ? _windowHeight
            : _windowHeight - (_windowHeight / 2);
        _lregisterYOffset = _windowHeight;

        _loginOpacity = 1;

        _headingTop = 90;

        break;
      case 2:
        _backGroundColor = AppTheme.topBarBackgroundColor;
        _loginYOffset = keyboardVisibility ? 30 : (_windowHeight / 2);
        _loginHeight = keyboardVisibility ? _windowHeight : _windowHeight - 200;

        _lregisterYOffset = keyboardVisibility ? 50 : 250;
        _registerHeight =
            keyboardVisibility ? _windowHeight : _windowHeight - 250;

        _loginOpacity = 0.7;

        _headingTop = 80;

        break;
      default:
    }

    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        print("State ${state}");
        if (state is AuthGetFailureState) {
          print("State ${state.error}");
          _alertError();
        } else if (state is AuthGetSuccess) {
          print("State ${state.user.responsecode}");
          // ignore: unrelated_type_equality_checks
          if (state.user.responsecode == "1") {
            _alertSuccess();
            _sharedInfo.sharedLoginInfo(state.user.user);
          } else {
            _alertError();
          }
          setState(() {
            _pageState = 0;
          });
        } else if (state is AuthLoadingState)
          _alertLoading();
        else if (state is AuthLoggedInState) gotoHomePage();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          top: false,
          bottom: false,
          child: Stack(children: [
            _homeContainer(),
            _loginContainer(),
            _registerContainer(),
          ]),
        ),
      ),
    );
  }

  Widget _homeContainer() {
    return AnimatedContainer(
      curve: Curves.fastLinearToSlowEaseIn,
      duration: Duration(
        microseconds: 1000,
      ),
      color: _backGroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _pageState = 0;
              });
            },
            child: AnimatedContainer(
              curve: Curves.fastLinearToSlowEaseIn,
              duration: Duration(
                microseconds: 1000,
              ),
              padding: EdgeInsets.only(top: _headingTop),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      Strings.getStartedButton,
                      style: Theme.of(context).textTheme.headline4,
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      margin: EdgeInsets.all(16),
                      child: Text(
                        Strings.welcomeScreenSubTitle,
                        style: Theme.of(context).textTheme.caption,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(
              child: Image.asset(Images.homeImage),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  if (_pageState != 0)
                    _pageState = 0;
                  else
                    _pageState = 1;
                });
              },
              child: Container(
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: AppTheme.selectedTabBackgroundColor,
                    borderRadius: BorderRadius.circular(16)),
                width: double.infinity,
                child: Center(
                  child: Text(
                    Strings.getStartedButton,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _loginContainer() {
    return AnimatedContainer(
      height: _loginHeight,
      padding: EdgeInsets.all(26),
      curve: Curves.fastLinearToSlowEaseIn,
      duration: Duration(milliseconds: 1000),
      transform: Matrix4.translationValues(0, _loginYOffset, 1),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(_loginOpacity),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(26),
            topRight: Radius.circular(26),
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 32),
                child: Text(
                  "Login to Continue",
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              InputWithIcon(
                inputText: "Enter Email",
                icon: Icons.email,
                controller: _userEmail,
              ),
              SizedBox(height: 16),
              InputWithIcon(
                inputText: "Enter Password",
                icon: Icons.lock,
                controller: _userPass,
              ),
            ],
          ),
          SizedBox(height: 16),
          Column(
            children: [
              GestureDetector(
                  onTap: () {
                    String email = _userEmail.text.trim();
                    String pass = _userPass.text.trim();

                    _authenticationBloc
                        .add(LoginEvent(email: email, password: pass));
                  },
                  child: PrimaryButton(btnText: "Sign In")),
              SizedBox(height: 16),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      _pageState = 2;
                    });
                  },
                  child: OutLineBtn(btnText: "Sign Up")),
            ],
          )
        ],
      ),
    );
  }

  Widget _registerContainer() {
    return AnimatedContainer(
      height: _registerHeight,
      padding: EdgeInsets.all(26),
      curve: Curves.fastLinearToSlowEaseIn,
      duration: Duration(milliseconds: 1000),
      transform: Matrix4.translationValues(0, _lregisterYOffset, 1),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(26),
            topRight: Radius.circular(26),
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 32),
                child: Text(
                  "Create New Account",
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              InputWithIcon(
                inputText: "Enter Full Name",
                icon: Icons.person,
                controller: _userName,
              ),
              SizedBox(height: 16),
              InputWithIcon(
                inputText: "Enter Email",
                icon: Icons.email,
                controller: _userEmail,
              ),
              SizedBox(height: 16),
              InputWithIcon(
                inputText: "Enter Password",
                icon: Icons.lock,
                controller: _userPass,
              ),
            ],
          ),
          SizedBox(height: 16),
          Column(
            children: [
              PrimaryButton(btnText: "Create Account"),
              SizedBox(height: 16),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      _pageState = 1;
                    });
                  },
                  child: OutLineBtn(btnText: "Back To Login")),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  void _alertLoading() {
    SweetAlert.show(context,
        subtitle: "loading...", style: SweetAlertStyle.loading);
  }

  void _alertSuccess() {
    SweetAlert.show(context,
        title: "Just show a message",
        subtitle: "Sweet alert is pretty",
        style: SweetAlertStyle.success);
  }

  void _alertError() {
    SweetAlert.show(context,
        title: "Just show a message",
        subtitle: "Sweet alert is pretty",
        style: SweetAlertStyle.error);
  }

  void gotoHomePage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LandingHomePage();
    }));
  }
}

class PrimaryButton extends StatefulWidget {
  final String btnText;
  const PrimaryButton({this.btnText});

  @override
  _PrimaryButtonState createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppTheme.selectedTabBackgroundColor,
          borderRadius: BorderRadius.circular(50)),
      padding: EdgeInsets.all(20),
      child: Center(
        child:
            Text(widget.btnText, style: Theme.of(context).textTheme.headline6),
      ),
    );
  }
}

class OutLineBtn extends StatefulWidget {
  final String btnText;

  const OutLineBtn({Key key, this.btnText}) : super(key: key);

  @override
  _OutLineBtnState createState() => _OutLineBtnState();
}

class _OutLineBtnState extends State<OutLineBtn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border:
              Border.all(color: AppTheme.selectedTabBackgroundColor, width: 2),
          borderRadius: BorderRadius.circular(50)),
      padding: EdgeInsets.all(15),
      child: Center(
        child:
            Text(widget.btnText, style: Theme.of(context).textTheme.headline6),
      ),
    );
  }
}

class InputWithIcon extends StatefulWidget {
  final String inputText;
  final IconData icon;
  final TextEditingController controller;

  const InputWithIcon({Key key, this.inputText, this.icon, this.controller})
      : super(key: key);

  @override
  _InputWithIconState createState() => _InputWithIconState();
}

class _InputWithIconState extends State<InputWithIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.hintTextColor, width: 2),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            child: Icon(
              widget.icon,
              size: 20,
              color: AppTheme.hintTextColor,
            ),
          ),
          Expanded(
              child: TextField(
            controller: widget.controller,
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 20),
                hintText: widget.inputText),
          ))
        ],
      ),
    );
  }
}
