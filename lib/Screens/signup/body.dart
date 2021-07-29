import 'package:authapp/Screens/login/splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:authapp/Screens/logoutscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  late String _email, _password, _name;

  navigateToLogout() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LogoutScreen()));
  }

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        navigateToLogout();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
  }

  signup() async {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();

      UserCredential user = await _auth.createUserWithEmailAndPassword(
          email: _email, password: _password);
      print("New User created!!!!");
      // ignore: unnecessary_null_comparison
      if (user != null) {
        await _auth.currentUser!.updateDisplayName(_name);
      }
    }
  }

  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        children: [
          SizedBox(height: 30),
          signuptitle(),
          SizedBox(height: 40),
          // fields
          Container(
            margin: EdgeInsets.symmetric(horizontal: 35),
            child: Column(children: [
              TextFormField(
                onChanged: (value) {},
                onSaved: (input) => _name = input!,
                obscureText: false,
                validator: (input) {
                  if (input!.isEmpty) {
                    return "Please Enter Username";
                  }
                  return null;
                },
                style: TextStyle(
                    color: Color(0xFFffe6e6), fontWeight: FontWeight.w300),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    CupertinoIcons.person,
                    color: Color(0xFFff9999),
                    size: 20,
                  ),
                  filled: true,
                  fillColor: Colors.transparent,
                  hintText: 'Username',
                  hintStyle: TextStyle(
                      fontSize: 13,
                      color: Color(0xFFffe6e6),
                      fontWeight: FontWeight.w200),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFff9999))),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFff9999))),
                ),
              ),
            ]),
          ),
          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 35),
            child: Column(children: [
              TextFormField(
                onChanged: (value) {},
                onSaved: (input) => _email = input!,
                obscureText: false,
                validator: (input) {
                  if (input!.isEmpty) {
                    return "Please Enter Email Id";
                  }
                  return null;
                },
                style: TextStyle(
                    color: Color(0xFFffe6e6), fontWeight: FontWeight.w300),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    CupertinoIcons.mail,
                    color: Color(0xFFff9999),
                    size: 20,
                  ),
                  filled: true,
                  fillColor: Colors.transparent,
                  hintText: 'Email Id',
                  hintStyle: TextStyle(
                      fontSize: 13,
                      color: Color(0xFFffe6e6),
                      fontWeight: FontWeight.w200),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFff9999))),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFff9999))),
                ),
              ),
            ]),
          ),
          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 35),
            child: Column(children: [
              TextFormField(
                onChanged: (input) {},
                onSaved: (input) => _password = input!,
                obscureText: false,
                validator: (input) {
                  if (input!.isEmpty) {
                    return "Please Enter Password";
                  } else if (input.length < 5) {
                    return "Lenght should be longer";
                  }
                  return null;
                },
                style: TextStyle(
                    color: Color(0xFFffe6e6), fontWeight: FontWeight.w300),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    CupertinoIcons.lock,
                    color: Color(0xFFff9999),
                    size: 20,
                  ),
                  filled: true,
                  fillColor: Colors.transparent,
                  hintText: 'Password',
                  hintStyle: TextStyle(
                      fontSize: 13,
                      color: Color(0xFFffe6e6),
                      fontWeight: FontWeight.w200),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFff9999))),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFff9999))),
                ),
              ),
            ]),
          ),

          SizedBox(height: 60),
          GestureDetector(
            onTap: signup,
            child: Container(
              height: 50,
              margin: EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                  color: Color(0xFFff9999),
                  borderRadius: BorderRadius.circular(7)),
              child: Center(
                child: Text("SIGN UP",
                    style: GoogleFonts.ptSans(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.white)),
              ),
            ),
          ),

          SizedBox(height: 30),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, SplashScreen.routeName),
            child: Center(
              child: Text(
                "Login",
                style: GoogleFonts.ptSans(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFFff9999)),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class signuptitle extends StatelessWidget {
  const signuptitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Create Account",
            style: GoogleFonts.dmSans(
                color: Color(0xFfffe6e6),
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
