import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_keep_clone/ui/main_navbar.dart';
import 'package:google_keep_clone/ui/note_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

Future<dynamic> func() async {
  FirebaseFirestore ffs = FirebaseFirestore.instance;
  CollectionReference cr = ffs.collection("notes");

  QuerySnapshot qs = await cr
      .where("owner", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .get();

  List<Map<String, dynamic>> data =
      qs.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();

  return data;
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
            future: func(),
            builder: (context, data) {
              if (data.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (data.hasError) {
                return Center(child: Text("${data.error.toString()}"));
              } else if (data.hasData) {
                List<Map<String, dynamic>> notes = data.data!;
                return Column(
                  children: [
                    MainNavBar(),
                    SizedBox(height: 30),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: ListView.builder(
                          itemCount: notes.length,
                          itemBuilder: (context, index) {
                            var note = notes[index];
                            return NoteCard(
                                title: note['title'], body: note['body']);
                          },
                        ),
                      ),
                    )
                  ],
                );
              } else {
                return Center(child: Text("There is no data"));
              }
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, "/edit_note");
          },
          backgroundColor: Colors.indigo.shade800,
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 35,
          ),
        ),
      ),
    );
  }
}
