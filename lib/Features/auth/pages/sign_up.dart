import 'package:flutter/material.dart';
import 'package:new_app/Features/Home/view/home_screen.dart';
import 'package:new_app/Features/auth/pages/sign_in.dart';
import 'package:new_app/Features/auth/auth_widgets/auth_card.dart';
import 'package:new_app/Features/widgets/app_buttons.dart';
import 'package:new_app/Features/widgets/app_icons.dart';
import 'package:new_app/Features/widgets/app_textfields.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
final TextEditingController nameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();


  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f3f5),
      body: Center(
        child: AuthCard(
          leftChild: Container(
            decoration: BoxDecoration(
              color: Colors.teal[400],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      "Welcome Back!",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "To keep connected with us please\nlogin with your personal info",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white70),
                    ),
                    SizedBox(height: 20),
                  CustomOutlinedButton(
                    text: 'SIGN IN',
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen()));
                    },
                  ),
                ],
                ),
              ),
            ),
          ),
          rightChild: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal[700],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    icons(Icons.facebook),
                    SizedBox(width: 10),
                    icons(Icons.g_mobiledata),
                    SizedBox(width: 10),
                    icons(Icons.linked_camera),
                  ],
                ),
                SizedBox(height: 10),
                Text("or use your email for registration:"),
                SizedBox(height: 10),
                AppTextField(
                   controller: nameController,
                   hintText: 'Name',
                   prefixIcon: Icons.person,
                   keyboardType: TextInputType.name,
                ),
                SizedBox(height: 10),
                AppTextField(
                  controller: emailController,
                  hintText: 'Email',
                  prefixIcon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 10),
                AppTextField(
                  controller: passwordController,
                   hintText: 'Password',
                   prefixIcon: Icons.password,
                   isPassword: true,
                   //keyboardType: TextInputType.visiblePassword,
                ),
                SizedBox(height: 20),
                CustomOutlinedButton(
                  text: 'SIGN UP',
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
