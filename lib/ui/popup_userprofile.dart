import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PopUpUserProfile extends StatelessWidget {
  final String imagePath;
  final String name;
  final String email;
  final String phone;

  const PopUpUserProfile({
    Key? key,
    required this.imagePath,
    required this.name,
    required this.email,
    required this.phone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: 350,
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(imagePath), // صورة المستخدم
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, "/edit_info");
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurStyle: BlurStyle.outer,
                          blurRadius: 2,
                        )
                      ],
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.all(5),
                    child: Icon(Icons.edit),
                  ),
                )
              ],
            ),
            SizedBox(height: 20),
            Text(
              name, // اسم المستخدم
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Email: $email", // البريد الإلكتروني
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            SizedBox(height: 5),
            Text(
              "Phone: $phone", // رقم الهاتف
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // إغلاق الـ Popup
                  },
                  child: Text("Close"),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.pushReplacementNamed(context, "/login");
                  },
                  child: Text("Sign out"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
