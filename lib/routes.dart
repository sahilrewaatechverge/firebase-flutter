import 'package:firebase_flutter/screens/phonelogin/phonelogin.dart';
import 'package:flutter/material.dart';
import 'package:firebase_flutter/repo/authrepository.dart';

class Router {
  static final authRepo = AuthRepository();

  static Route genretedRoutes(RouteSettings settings) {
    return MaterialPageRoute(builder: (_) => PhoneLogin());
  }
}
