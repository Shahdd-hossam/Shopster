import 'package:flutter/material.dart';
import 'package:new_app/Features/Home/view/home_screen.dart';
import 'package:new_app/Features/auth/pages/sign_in.dart';
import 'package:new_app/Features/auth/auth_widgets/auth_card.dart';
import 'package:new_app/Features/widgets/app_buttons.dart';
import 'package:new_app/Features/widgets/app_icons.dart';
import 'package:new_app/Features/widgets/app_textfields.dart';
import 'package:new_app/core/validators/app_validators_types/confirm_password_validator.dart';
import 'package:new_app/core/validators/app_validators_types/email_app_validator.dart';
import 'package:new_app/core/validators/app_validators_types/password_app_validator.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
final TextEditingController nameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final TextEditingController confirmpasswordController = TextEditingController();
final EmailAppValidator emailAppValidator = EmailAppValidator();
final PasswordAppValidator passwordAppValidator = PasswordAppValidator();
final ConfirmPasswordAppValidator confirmPasswordAppValidator = ConfirmPasswordAppValidator(password: '', confirmPassword: '');
bool isObsecure = true;
bool isFormValid = false;

void validateForm() {
  // Update validator values
  emailAppValidator.setValue(emailController.text);
  passwordAppValidator.setValue(passwordController.text);
  confirmPasswordAppValidator.comparedWithPassword = passwordController.text;
  confirmPasswordAppValidator.setValue(confirmpasswordController.text);

  // Check if all fields are filled
  bool allFieldsFilled = emailController.text.isNotEmpty && passwordController.text.isNotEmpty &&
  confirmpasswordController.text.isNotEmpty;

  // Check if all validators return no errors
  bool noValidationErrors = emailAppValidator.check().isEmpty &&passwordAppValidator.check().isEmpty &&
  confirmPasswordAppValidator.check().isEmpty;

  setState(() {
    isFormValid = allFieldsFilled && noValidationErrors;
  });
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
                      "Welcome to our app!",
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
                   hint: "Name",
                   prefixIcon: Icon(Icons.person),
                    onChange: (v) {
                      setState(() {
                      });
                    },
                ),
                SizedBox(height: 10),
                AppTextField(
                   controller: emailController,
                   validator: emailAppValidator,
                   hint: "Email Address",
                   prefixIcon: Icon(Icons.email),
                    onChange: (v) {
                      setState(() {
                        emailAppValidator.setValue(v);
                        validateForm();
                      });
                    },
                ),
                SizedBox(height: 10),
                AppTextField(
                   controller: passwordController,
                   obscureText: isObsecure,
                   validator: passwordAppValidator,
                   hint: 'password',
                   prefixIcon: Icon(Icons.lock),
                    onChange: (v) {
                      setState(() {
                        passwordAppValidator.setValue(v);
                        validateForm();
                      });
                    },
                suffixIcon: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  setState(() {
                    isObsecure = !isObsecure;
                  });
                },
                child: Icon(
                  isObsecure ? Icons.visibility_off : Icons.visibility,
                  size: 20,
                  color: Colors.grey,
                ),
              ),
                ),
                SizedBox(height: 10),
                AppTextField(
                   controller: confirmpasswordController,
                   obscureText: isObsecure,
                   validator: confirmPasswordAppValidator,
                   hint: 'confirm password',
                   prefixIcon: Icon(Icons.lock),
                    onChange: (v) {
                      setState(() {
                        confirmPasswordAppValidator.setValue(v);
                        validateForm();
                      });
                    },
                suffixIcon: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  setState(() {
                    isObsecure = !isObsecure;
                  });
                },
                child: Icon(
                  isObsecure ? Icons.visibility_off : Icons.visibility,
                  size: 20,
                  color: Colors.grey,
                ),
              ),
                ),
                SizedBox(height: 20),
                CustomOutlinedButton(
                  text: 'SIGN UP',
                  onPressed: isFormValid
                      ? () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                        }
                      : null, // Disabled if form is invalid
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
