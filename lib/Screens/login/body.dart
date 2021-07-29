import 'package:authapp/Screens/logoutscreen.dart';
import 'package:authapp/Screens/signup/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  // ignore: unused_field
  late String _email, _password;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        print(user.email);
        navigateToLogout();
      }
    });
  }

  navigateToLogout() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LogoutScreen()));
  }

  navigateToRegister() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
  }

  login() async {
    if (_loginFormKey.currentState!.validate()) {
      _loginFormKey.currentState!.save();

      try {
        await _auth.signInWithEmailAndPassword(
            email: _email, password: _password);
        print("One Login done !!");
        await navigateToLogout();
        setState(() {});
      } catch (e) {
        showError(e.toString());
        print(e);
      }
    }
  }

  showError(String errormessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ERROR'),
            content: Text(errormessage),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _loginFormKey,
        child: Container(
            color: Color(0xFFff8080),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, SignUp.routeName);
                        },
                        icon: Icon(
                          CupertinoIcons.bars,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(vertical: 25),
                          child: Text(
                            "Sign In",
                            style: GoogleFonts.ptSans(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          )),
                      IconButton(
                        onPressed: () {
                          // navigateToLogout();
                        },
                        icon: Icon(
                          CupertinoIcons.forward,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 538,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.elliptical(32, 32),
                          topRight: Radius.elliptical(32, 32))),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 50),
                      Text(
                        "Sign In using Firebase",
                        style: GoogleFonts.ptSans(
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                            color: Colors.black
                            // color: Color(0xFFff9999),
                            ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Enter your Email ID and Password \nand come on Logout page",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.ptSans(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(height: 50),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 35),
                        child: TextFormField(
                          onSaved: (input) => _email = input!,
                          onChanged: (input) {},
                          obscureText: false,
                          validator: (input) {
                            if (input!.isEmpty) {
                              return "Please Enter Email Id";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(CupertinoIcons.mail,
                                color: Color(0xFFff9999), size: 20),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Email Id',
                            hintStyle: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[500],
                                fontWeight: FontWeight.w300),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFFff9999))),
                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFFff9999))),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 35),
                        child: TextFormField(
                          onSaved: (input) => _password = input!,
                          onChanged: (input) {},
                          obscureText: false,
                          validator: (input) {
                            if (input!.isEmpty) {
                              return "Please Enter Password";
                            } else if (input.length < 6) {
                              return "Password should be 6 digit";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(CupertinoIcons.lock,
                                color: Color(0xFFff9999), size: 20),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: '******',
                            hintStyle: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[500],
                                fontWeight: FontWeight.w300),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFFff9999))),
                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFFff9999))),
                          ),
                        ),
                      ),
                      SizedBox(height: 60),
                      GestureDetector(
                        onTap: login,
                        child: Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          decoration: BoxDecoration(
                              color: Color(0xFFff9999),
                              borderRadius: BorderRadius.circular(7)),
                          child: Center(
                            child: Text(
                              "SIGN IN",
                              style: GoogleFonts.ptSans(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, SignUp.routeName);
                        },
                        child: Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          decoration: BoxDecoration(
                              color: Color(0xFFff9999),
                              borderRadius: BorderRadius.circular(7)),
                          child: Center(
                            child: Text(
                              "SIGN UP",
                              style: GoogleFonts.ptSans(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
