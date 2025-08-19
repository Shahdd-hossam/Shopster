import 'package:flutter/material.dart';
import 'package:new_app/common/app_colors.dart';
import 'package:new_app/common/app_textfields.dart';
import 'package:new_app/core/validators/app_validator_types/email_validator.dart';
import 'package:new_app/core/validators/app_validator_types/password_validator.dart';
import 'package:new_app/features/auth/signup_screen.dart';
import 'package:new_app/core/services/auth_service.dart';
import 'package:new_app/core/di/product_service_locator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isObscured = true;
  bool isChecked = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final EmailAppValidator emailAppValidator = EmailAppValidator();
  final PasswordAppValidator passwordValidator = PasswordAppValidator();
  
  late AuthService authService;

  @override
  void initState() {
    super.initState();
    authService = sl<AuthService>();
  }

  Future<void> _handleLogin() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final success = await authService.login(
      username: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    if (success) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login failed. Please check your credentials.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: AppColors.background, 
    body: Center(
      child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
        child: LayoutBuilder(
        builder: (context, constraints) {
          double maxWidth = constraints.maxWidth < 500 ? constraints.maxWidth : 400;
          return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
            maxWidth: maxWidth,
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

                // Login Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.black,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: authService.isLoading ? null : _handleLogin,
                    child: authService.isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            'LOGIN',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
                
                const SizedBox(height: 15),
                
                // Sign Up Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account? ',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpPage(),
                          ),
                        );
                      },
                      child: Text(
                        'Sign Up',
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
      );
    },
  )
  )
  )
  )
  );
 }
}

