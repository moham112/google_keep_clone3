import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_keep_clone/ui/popup_userprofile.dart';

class MainNavBar extends StatelessWidget {
  Future<DocumentSnapshot?> getUser() async {
    FirebaseFirestore ffs = FirebaseFirestore.instance;
    CollectionReference cr = ffs.collection("users");

    QuerySnapshot querySnapshot = await cr
        .where("user_id", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first;
    } else {
      return null;
    }
  }

  // ignore: unused_element
  void _showUserDetails(BuildContext context) async {
    dynamic user = await getUser();
    Map<String, dynamic> userData = user.data() as Map<String, dynamic>;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PopUpUserProfile(
          imagePath: "assets/user.jpg",
          name: userData['name'],
          email: FirebaseAuth.instance.currentUser!.email!,
          phone: userData['phone'],
        );
      },
    );
  }

  const MainNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade50,
        borderRadius: BorderRadius.circular(30),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
      margin: EdgeInsets.only(right: 15, left: 15, top: 20),
      child: Row(
        children: [
          Icon(Icons.menu),
          SizedBox(width: 10),
          Text(
            "Search your notes",
            style: GoogleFonts.roboto(
              fontSize: 17,
              color: Colors.blueGrey.shade900,
            ),
          ),
          Spacer(),
          Icon(Icons.grid_view),
          SizedBox(width: 15),
          InkWell(
            child: Icon(Icons.person),
            onTap: () {
              _showUserDetails(context);
            },
          )
        ],
      ),
    );
  }
}
