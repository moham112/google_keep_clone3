import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
// import 'package:fluttertoast/fluttertoast.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_keep_clone/ui/ktext_form_field.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email_ctrl = TextEditingController();
  TextEditingController password_ctrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            SizedBox(height: 100),
            Image.asset(
              "assets/keep.png",
              width: 70,
              height: 70,
            ),
            SizedBox(height: 50),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(width: 0.5, color: Colors.black),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      "Start write your thoughts",
                      style: GoogleFonts.roboto(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 25),
                    KTextFormField(
                      hint: "Email",
                      controller: email_ctrl,
                    ),
                    SizedBox(height: 20),
                    KTextFormField(
                      hint: "Password",
                      controller: password_ctrl,
                      obscurity: true,
                    ),
                    SizedBox(height: 20),
                    InkWell(
                      onTap: () async {
                        await FirebaseAuth.instance.sendPasswordResetEmail(
                          email: email_ctrl.text,
                        );
                      },
                      child: Text(
                        "Forget Password?",
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Color(0xfffabe2b)),
                      onPressed: () async {
                        try {
                          // ignore: unused_local_variable
                          final credential = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                            email: email_ctrl.text,
                            password: password_ctrl.text,
                          );
                          Navigator.pushReplacementNamed(context, '/home');
                        } on FirebaseAuthException catch (e) {
                          print("The code is ${e.code}");
                          if (e.code == "too-many-requests") {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: const Text('Too many attempts')));
                          } else if (e.code == "invalid-credential") {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: const Text(
                                    'Your email or password doesn\'t exists')));
                          } else if (e.code == 'user-not-found') {
                            print('No user found for that email.');
                          } else if (e.code == 'wrong-password') {
                            print('Wrong password provided for that user.');
                          }
                        }
                      },
                      child: Text(
                        "Login",
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed("/register");
                      },
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: "Don't have account? ",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: "Register",
                            style: TextStyle(
                              color: Color(0xfffabe2b),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          TextSpan(
                            text: " Instead!",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          )
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
