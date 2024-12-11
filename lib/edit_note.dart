import "package:cloud_firestore/cloud_firestore.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_keep_clone/ui/navbar.dart';

class EditNote extends StatefulWidget {
  const EditNote({super.key});

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  // CollectionReference users = FirebaseFirestore.instance.collection('users');

  // Future<void> addUser() {
  //   // Call the user's CollectionReference to add a new user
  //   return users
  //       .add({""})
  //       .then((value) => print("User Added"))
  //       .catchError((error) => print("Failed to add user: $error"));
  // }

  TextEditingController title_ctrl = TextEditingController();
  TextEditingController body_ctrl = TextEditingController();

  Future<void> submitNote(String title, String body) async {
    FirebaseFirestore ffs = FirebaseFirestore.instance;
    CollectionReference cf = ffs.collection("notes");

    String owner_id = FirebaseAuth.instance.currentUser!.uid;

    await cf
        .add({"title": title, "body": body, "owner": owner_id}).then((value) {
      print("========== Data Added =======");
      Navigator.pushReplacementNamed(context, "/home");
    }).catchError((error) {
      print(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Navbar(),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  TextField(
                    controller: title_ctrl,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Title",
                      hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                  TextField(
                    controller: body_ctrl,
                    maxLines: null,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Note",
                      hintStyle: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.add_box_outlined), label: ""),
            BottomNavigationBarItem(
              icon: Icon(Icons.palette),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.text_fields),
              label: "",
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.indigo.shade800,
            onPressed: () {
              submitNote(title_ctrl.text, body_ctrl.text);
            },
            child: Icon(
              Icons.done,
              color: Colors.white,
            )),
      ),
    );
  }
}
