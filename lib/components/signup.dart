import 'package:ecommerce2/components/home.dart';
import 'package:ecommerce2/components/login.dart';
import 'package:ecommerce2/components/pages/bttomnav.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:random_string/random_string.dart';
import 'package:ecommerce2/service/database.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String? email, password, name;
  final _Formkey = GlobalKey<FormState>();
  TextEditingController namecontroller = new TextEditingController();
  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();
  Future<UserCredential?> registration(String email, String password) async {
    print('registration is called');
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            'Registered successfully',
            style: TextStyle(fontSize: 20),
          )));
      String id = randomAlphaNumeric(10);
      Map<String, dynamic> userinfoMap = {
        "name": namecontroller.text,
        "email": emailcontroller.text,
        "id": id,
        'image':
            " https://www.google.com/search?q=image&oq=image&gs_lcrp=EgZjaHJvbWUqCggAEAAYsQMYgAQyCggAEAAYsQMYgAQyCggBEAAYsQMYgAQyCggCEAAYsQMYgAQyEAgDEAAYgwEYsQMYgAQYigUyBwgEEAAYgAQyDQgFEAAYgwEYsQMYgAQyCggGEAAYsQMYgAQyBggHEEUYPdIBBzk3N2owajeoAgiwAgHxBXF0_TuiMXnX8QVxdP07ojF51w&sourceid=chrome&ie=UTF-8#vhid=2brKLR3s5kTpPM&vssid=_TlsHaITzDqCQ9u8Pu-mz8Qw_67 "
      };
      await DatabaseMethods().adduserdetails(userinfoMap, id);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              'Weak password, please use a stronger one',
              style: TextStyle(fontSize: 20),
            )));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              'Account already exists',
              style: TextStyle(fontSize: 20),
            )));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              'Registration failed: ${e.message}',
              style: TextStyle(fontSize: 20),
            )));
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 50, left: 10, right: 10),
          child: Form(
            key: _Formkey,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 136, 135, 130)),
                  child: Image.asset(
                    'images/login.jpg',
                    height: 280,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Sign up',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Text(
                          '  Please enter the detail below to\n                      continue',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Text(
                            'Name',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: EdgeInsets.all(3),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromARGB(255, 235, 232, 232),
                      ),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please enter your name';
                          }
                          return null;
                        },
                        controller: namecontroller,
                        decoration: InputDecoration(
                          hintText: ' eg.  dejen',
                          hintStyle: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w200),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Text(
                            'Email',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: EdgeInsets.all(3),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromARGB(255, 235, 232, 232),
                      ),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please enter your email';
                          }
                          return null;
                        },
                        controller: emailcontroller,
                        decoration: InputDecoration(
                          hintText: ' eg. a@gmail.com',
                          hintStyle: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w200),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          '   Password',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: EdgeInsets.all(3),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromARGB(255, 235, 232, 232),
                      ),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please enter your password';
                          }
                          return null;
                        },
                        controller: passwordcontroller,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: '   password',
                          hintStyle: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w200),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      padding: EdgeInsets.all(2),
                      width: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.green,
                      ),
                      child:

                          /// The `TextButton` widget you provided is handling the sign-up
                          /// functionality in your Flutter application. Here's a breakdown of what it
                          /// does:
                          TextButton(
                        onPressed: () async {
                          if (_Formkey.currentState!.validate()) {
                            String name = namecontroller.text.trim();
                            String email = emailcontroller.text.trim();
                            String password = passwordcontroller.text;

                            UserCredential? user =
                                await registration(email, password);
                            if (user != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Buttomnav()),
                              );
                            }
                          }
                        },
                        child: Text(
                          'Sign up',
                          style: TextStyle(fontSize: 23, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Text(
                        "Already have account? ",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w200),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()));
                          },
                          child: Text(
                            'Sign in',
                            style: TextStyle(
                                fontSize: 22, color: Colors.greenAccent),
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
