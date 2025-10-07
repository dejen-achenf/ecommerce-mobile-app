import 'package:ecommerce2/components/pages/bttomnav.dart';
import 'package:ecommerce2/components/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? email, password;
  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();
  final _Formkey = GlobalKey<FormState>();

  // 1. Update the function to accept context

  Future<bool> userlogin(BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!);
      return true;
    } on FirebaseAuthException catch (e) {
      print('🔥 Firebase Error Code: ${e.code}');
      print('🔥 Firebase Message: ${e.message}');
      String x = e.code;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          x,
          style: TextStyle(fontSize: 20),
        ),
      ));

      return false;
    }
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
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Sign in',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 30,
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
                      height: 20,
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
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () async {
                              await FirebaseAuth.instance
                                  .sendPasswordResetEmail(email: email!);
                            },
                            child: Text(
                              'Forget password?',
                              style: TextStyle(
                                  fontSize: 20, color: Colors.greenAccent),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.all(2),
                      width: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.green,
                      ),
                      child: TextButton(
                          // 2. Inside onPressed — update this part only
                          onPressed: () async {
                            if (_Formkey.currentState!.validate()) {
                              email = emailcontroller.text.trim();
                              password = passwordcontroller.text.trim();

                              bool success = await userlogin(context);
                              if (success) {
                                if (!mounted) return;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Buttomnav()),
                                );
                              }
                            }
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(fontSize: 23, color: Colors.white),
                          )),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w200),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Signup()));
                          },
                          child: Text(
                            'Sign up',
                            style: TextStyle(
                                fontSize: 20, color: Colors.greenAccent),
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
