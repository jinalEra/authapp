import 'package:authapp/Screens/signup/signup.dart';
import 'package:authapp/Screens/login/splash.dart';
import 'package:authapp/Screens/start/start.dart';
import 'package:flutter/material.dart';


final Map<String, WidgetBuilder> routes = {


    StartScreen.routeName: (context) => StartScreen(),
    SplashScreen.routeName: (context) => SplashScreen(),
    SignUp.routeName: (context) => SignUp()
   
};