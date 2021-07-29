import 'package:authapp/Screens/login/splash.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartScreen extends StatelessWidget {
  static String routeName = "/start";

  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF280479),
      body: Container(
        constraints: BoxConstraints.expand(),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, SplashScreen.routeName),
              child: Container(
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                    color: Color(0xFFff9999),
                    borderRadius: BorderRadius.circular(7)),
                child: Center(
                  child: Text("SIGN IN",
                      style: GoogleFonts.ptSans(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
