import 'package:flutter/material.dart';
import 'package:new_app/common/app_colors.dart';
import 'package:new_app/common/app_textfields.dart';
import 'package:new_app/core/validators/app_validator_types/confirm_password_validator.dart';
import 'package:new_app/core/validators/app_validator_types/email_validator.dart';
import 'package:new_app/core/validators/app_validator_types/password_validator.dart';
import 'package:new_app/features/auth/login_screen.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  bool isObscured = true;
  bool isChecked = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final EmailAppValidator emailAppValidator = EmailAppValidator();
  final PasswordAppValidator passwordValidator = PasswordAppValidator();
  final ConfirmPasswordAppValidator confirmPasswordValidator = ConfirmPasswordAppValidator();

  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: AppColors.background, 
    body: Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
          child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 400, 
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.grey.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Profile Icon
                CircleAvatar(
                  radius: 50,
                  backgroundColor: AppColors.primary,
                  child: Icon(Icons.person, size: 60, color: AppColors.surface),
                ),
                const SizedBox(height: 30),

                // Name TextField
                AppTextField(
                  hint: 'Name',
                  prefixIcon: const Icon(Icons.person),
                  controller: TextEditingController(),
                  onChange: (String value) {},
                ),
                const SizedBox(height: 15),

                // Email TextField
                AppTextField(
                  hint: 'Email',
                  prefixIcon: const Icon(Icons.email),
                  validator: emailAppValidator,
                  onChange: (v) {
                    setState(() {
                      emailAppValidator.setValue(v);
                    });
                  },
                  controller: emailController,
                ),

                const SizedBox(height: 15),

                // Password TextField
                  AppTextField(
                      hint: 'Password',
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          isObscured ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            isObscured = !isObscured;
                          });
                        },
                      ),
                      obscureText: isObscured,
                      validator: passwordValidator,
                      onChange: (v) {
                        setState(() {
                      passwordValidator.setValue(v);
                    });
                  },
                  controller: passwordController,
                ),
                
                const SizedBox(height: 15),

                // Confirm Password TextField
                AppTextField(
                  hint: 'Confirm Password',
                  prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          isObscured ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            isObscured = !isObscured;
                          });
                        },
                      ),
                      obscureText: isObscured,
                      validator: confirmPasswordValidator,
                      onChange: (v) {
                        setState(() {
                          confirmPasswordValidator.setValue(v);
                        });
                      },
                  controller: confirmPasswordController,
                ),

                // Remember Me & Forgot Password
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(value: isChecked, onChanged: (value) {
                          setState(() {
                            isChecked = value!;
                          });
                        }),
                        const Text('Remember me'),
                      ],
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Forgot password?'),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                // Sign Up Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.textLight,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                    child: const Text(
                      'SIGN UP',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                
                const SizedBox(height: 15),
                
                // Sign In Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 16, 
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ),
   ),
  ),
  );
 }
}