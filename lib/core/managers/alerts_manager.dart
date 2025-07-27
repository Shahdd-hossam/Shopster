import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_app/Features/widgets/app_buttons.dart';

class AlertManager {
  static void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.white,
        title: const Text(
          'Logout Confirmation',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
        content: const Text(
          'Are you sure you want to logout from your account?',
          style: TextStyle(fontSize: 18),
        ),
        actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        actions: [
          CustomOutlinedButton(
            text: 'Cancel',
            onPressed: () => Navigator.pop(context),
            borderColor: Colors.grey,
            textColor: Colors.grey,
          ),
          CustomOutlinedButton(
            text: 'Logout',
            onPressed: () {
              Navigator.pop(context); 
              Navigator.pop(context); 
              _showFancyToast(); 
            },
            borderColor: Colors.red,
            textColor: Colors.red,
          ),
        ],
      ),
    );
  }

  static void _showFancyToast() {
    Fluttertoast.showToast(
      msg: 'Successfully Logged Out!',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.teal[700],
      textColor: Colors.white,
      fontSize: 18.0,
    );
  Future.delayed(const Duration(seconds: 100), () {
  Fluttertoast.cancel();});
  }
}

