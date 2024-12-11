import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_keep_clone/ui/ktext_form_field.dart';

class EditInfo extends StatefulWidget {
  const EditInfo({super.key});

  @override
  State<EditInfo> createState() => _EditInfoState();
}

Future<Map<String, dynamic>> getUser() async {
  FirebaseFirestore ffs = FirebaseFirestore.instance;
  CollectionReference cr = ffs.collection("users");

  QuerySnapshot querySnapshot = await cr
      .where("user_id", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
      .get();

  if (querySnapshot.docs.isNotEmpty) {
    return querySnapshot.docs.first.data() as Map<String, dynamic>;
  } else {
    throw Exception("User not found");
  }
}

Future<void> updateUser(String name, String phone) async {
  FirebaseFirestore ffs = FirebaseFirestore.instance;
  CollectionReference usersCollection = ffs.collection("users");

  // مباشرة تحديث الوثيقة باستخدام استعلام
  await usersCollection
      .where("user_id", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
      .limit(1) // تحديد نتيجة واحدة فقط
      .get()
      .then((querySnapshot) async {
    if (querySnapshot.docs.isNotEmpty) {
      await usersCollection.doc(querySnapshot.docs.first.id).update({
        "name": name,
        "phone": phone,
      }).then((value) {
        print("User info updated successfully");
      }).catchError((error) {
        print("Error updating user: $error");
      });
    } else {
      throw Exception("User not found");
    }
  }).catchError((error) {
    print("Error fetching user: $error");
  });
}

class _EditInfoState extends State<EditInfo> {
  TextEditingController name_ctrl = TextEditingController();
  TextEditingController phone_ctrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 25, vertical: 100),
        height: 400,
        child: FutureBuilder(
          future: getUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> userData = snapshot.data!;
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "assets/keep.png",
                    height: 75,
                  ),
                  Text(
                    "My Information",
                    style: GoogleFonts.roboto(fontSize: 17),
                  ),
                  SizedBox(height: 10),
                  KTextFormField(
                    controller: name_ctrl..text = userData['name'],
                    hint: "First Name",
                  ),
                  KTextFormField(
                    controller: phone_ctrl..text = userData['phone'],
                    hint: "Phone Number",
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow.shade600,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        label: Text(
                          "Back",
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow.shade600,
                        ),
                        onPressed: () async {
                          await updateUser(name_ctrl.text, phone_ctrl.text);
                        },
                        child: Text(
                          "Save",
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              );
            } else {
              return Center(
                child: Text("Not found data"),
              );
            }
          },
        ),
      ),
    );
  }
}
