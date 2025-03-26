


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../global/common/toast.dart';

class ForgetPasswordPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();

  void _resetPassword(BuildContext context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text);
      showToast(message: "Password reset email sent!");
      Navigator.pop(context);
    } catch (e) {
      showToast(message: "Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Reset Password")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: _emailController, decoration: InputDecoration(hintText: "Enter your email")),
            SizedBox(height: 20),
            ElevatedButton(onPressed: () => _resetPassword(context), child: Text("Reset Password"))
          ],
        ),
      ),
    );
  }
}