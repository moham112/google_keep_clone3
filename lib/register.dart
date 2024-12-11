// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_keep_clone/ui/ktext_form_field.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController name_ctrl = TextEditingController();
    TextEditingController email_ctrl = TextEditingController();
    TextEditingController phone_ctrl = TextEditingController();
    TextEditingController password_ctrl = TextEditingController();

    final GlobalKey<FormState> formState = GlobalKey();

    return Scaffold(
      body: Scaffold(
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
              SizedBox(height: 15),
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
                        controller: name_ctrl,
                        hint: "Name",
                      ),
                      SizedBox(height: 15),
                      KTextFormField(
                        hint: "Email",
                        controller: email_ctrl,
                      ),
                      SizedBox(height: 15),
                      KTextFormField(
                        hint: "Phone Number",
                        controller: phone_ctrl,
                      ),
                      SizedBox(height: 15),
                      KTextFormField(
                        hint: "Password",
                        controller: password_ctrl,
                        obscurity: true,
                      ),
                      SizedBox(height: 15),
                      KTextFormField(
                        hint: "Confirm Password",
                        obscurity: true,
                      ),
                      SizedBox(height: 15),
                      TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Color(0xfffabe2b)),
                        onPressed: () async {
                          try {
                            final credential = await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                              email: email_ctrl.text,
                              password: password_ctrl.text,
                            );
                            FirebaseFirestore ffs = FirebaseFirestore.instance;
                            CollectionReference cr = ffs.collection("users");

                            await cr.add({
                              "user_id": FirebaseAuth.instance.currentUser?.uid
                                  .toString(),
                              "phone": phone_ctrl.text,
                              "name": name_ctrl.text,
                            });

                            Navigator.of(context).pushReplacementNamed("/home");
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              print('The password provided is too weak.');
                            } else if (e.code == 'email-already-in-use') {
                              print(
                                  'The account already exists for that email.');
                            }
                          } catch (e) {
                            print(e);
                          }
                          ;
                        },
                        child: Text(
                          "Register",
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "/login");
                        },
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: "Have account already? ",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: "Login ",
                              style: TextStyle(
                                  color: Color(0xfffabe2b),
                                  decoration: TextDecoration.underline),
                            ),
                            TextSpan(
                              text: "Instead!",
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
      ),
    );
  }
}
