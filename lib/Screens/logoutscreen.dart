import 'package:authapp/Screens/login/splash.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class LogoutScreen extends StatefulWidget {
  const LogoutScreen({Key? key}) : super(key: key);

  @override
  _LogoutScreenState createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User user;
  bool isloggedIn = false;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.of(context).pushReplacementNamed(SplashScreen.routeName);
      }
    });
  }

  getUser() async {
    User? firebaseUser = _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = _auth.currentUser;

    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser!;
        this.isloggedIn = true;
      });
    }
  }

  signOut() async {
    _auth.signOut();
    print(user.email);
    Navigator.pushNamed(context, SplashScreen.routeName);
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
    this.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 50, vertical: 100),
        child: !isloggedIn
            ? Center(child: CircularProgressIndicator())
            : Center(
                child: Column(
                  children: [
                    Text(
                      "Hello ${user.displayName},",
                      style: GoogleFonts.ptSans(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text.rich(
                      TextSpan(
                        text: "You are logged in as",
                        style: GoogleFonts.ptSans(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    SizedBox(
                        height: 30,
                        child: Text(
                          "${user.email}",
                          style: GoogleFonts.ptSans(
                              fontSize: 16,
                              color: Colors.purple,
                              fontWeight: FontWeight.w400),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: signOut,
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        decoration: BoxDecoration(
                            color: Color(0xFFff9999),
                            borderRadius: BorderRadius.circular(7)),
                        child: Center(
                          child: Text("Logout",
                              style: GoogleFonts.ptSans(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white)),
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    // GestureDetector(
                    //   onTap: () =>
                    //       Navigator.pushNamed(context, StartScreen.routeName),
                    //   child: Container(
                    //     height: 50,
                    //     margin: EdgeInsets.symmetric(horizontal: 30),
                    //     decoration: BoxDecoration(
                    //         color: Color(0xFFff9999),
                    //         borderRadius: BorderRadius.circular(7)),
                    //     child: Center(
                    //       child: Text("Back To Home",
                    //           style: GoogleFonts.ptSans(
                    //               fontSize: 15,
                    //               fontWeight: FontWeight.w400,
                    //               color: Colors.white)),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
      ),
    );
  }
}
