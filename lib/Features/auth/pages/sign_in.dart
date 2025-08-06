import 'package:flutter/material.dart';
import 'package:new_app/Features/Home/view/home_screen.dart';
import 'package:new_app/Features/auth/pages/sign_up.dart';
import 'package:new_app/Features/auth/auth_widgets/auth_card.dart';
import 'package:new_app/Features/widgets/app_buttons.dart';
import 'package:new_app/Features/widgets/app_colors.dart';
import 'package:new_app/Features/widgets/app_icons.dart';
import 'package:new_app/Features/widgets/app_strings.dart';
import 'package:new_app/Features/widgets/app_textfields.dart';
import 'package:new_app/core/validators/app_validators_types/email_app_validator.dart';
import 'package:new_app/core/validators/app_validators_types/password_app_validator.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}
bool isObscure = true;
class _SignInScreenState extends State<SignInScreen> {
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
EmailAppValidator emailAppValidator = EmailAppValidator();
PasswordAppValidator passwordAppValidator = PasswordAppValidator();
bool isObsecure = true;
bool isFormValid = false;

void validateForm() {
  //Update validator values
  emailAppValidator.setValue(emailController.text);
  passwordAppValidator.setValue(passwordController.text);

  //Check if all fields are filled
  bool allFieldsFilled = emailController.text.isNotEmpty && passwordController.text.isNotEmpty;

  //Check if all validators return no errors
  bool noValidationErrors = emailAppValidator.check().isEmpty && passwordAppValidator.check().isEmpty;

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
          leftChild: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  'Sign in to Shopster',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.teal,
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
                validator: emailAppValidator,
                hint: AppStrings.emailAddress,
                prefixIcon: Icon(Icons.email),
                keyboardType: TextInputType.emailAddress,
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
                   hint: AppStrings.password,
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
                SizedBox(height: 20),
                CustomOutlinedButton(
                  text: 'SIGN IN',
                  onPressed: isFormValid
                      ? () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                        }
                      : null, // Disabled if form is invalid
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
                      "Hello, welcome Back!",
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
