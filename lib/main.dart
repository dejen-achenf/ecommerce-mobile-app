import 'package:ecommerce2/components/home.dart';
import 'package:ecommerce2/components/welcome.dart';
import 'package:ecommerce2/components/pages/headphonedetail.dart';
import 'package:ecommerce2/components/pages/tvdetail.dart';
import 'package:ecommerce2/components/pages/laptopdetail.dart';
import 'package:ecommerce2/components/pages/watchdetail.dart';
import 'package:ecommerce2/components/login.dart';
import 'package:ecommerce2/components/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  return runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Login()));
}
