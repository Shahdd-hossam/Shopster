import 'package:flutter/material.dart';
import 'package:new_app/Features/Home/view/home_screen.dart';
import 'package:new_app/Features/auth/pages/sign_up.dart';
import 'package:new_app/Features/auth/auth_widgets/auth_card.dart';
import 'package:new_app/Features/widgets/app_buttons.dart';
import 'package:new_app/Features/widgets/app_icons.dart';
import 'package:new_app/Features/widgets/app_textfields.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
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
          leftChild: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  'Sign in to Diprella',
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
                Text("or use your email account:"),
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
                   keyboardType: TextInputType.visiblePassword,
                ),
                SizedBox(height: 10),
                CustomOutlinedButton(
                  text: 'SIGN IN',
                  onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                ),
              ],
            ),
          ),

          rightChild: Container(
            decoration: BoxDecoration(
              color: Colors.teal[400],
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Hello, Friend!",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Enter your personal details\nand start journey with us",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white70),
                    ),
                    SizedBox(height: 20),
                    CustomOutlinedButton(
                      text: 'SIGN UP',
                      onPressed: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
                    },
                  ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
