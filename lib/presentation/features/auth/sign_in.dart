import 'package:flutter/material.dart';
import 'package:new_task/presentation/features/auth/auth_card.dart';
import 'package:new_task/presentation/features/auth/sign_up.dart';
import 'package:new_task/presentation/features/home/view/home_screen.dart';
import 'package:new_task/presentation/features/widgets/app_buttons.dart';
import 'package:new_task/presentation/features/widgets/app_colors.dart';
import 'package:new_task/presentation/features/widgets/app_icons.dart';
import 'package:new_task/presentation/features/widgets/app_strings.dart';
import 'package:new_task/presentation/features/widgets/app_textfield.dart';
import 'package:new_task/core/validators/validator_type/password_validator.dart';
import 'package:new_task/core/validators/validator_type/username_validator.dart';
import 'package:new_task/core/controllers/user_controller.dart';
import 'package:new_task/core/models/user.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}
bool isObscure = true;
class _SignInScreenState extends State<SignInScreen> {
  final UserController _userController = UserController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final PasswordAppValidator passwordAppValidator = PasswordAppValidator();
  final UsernameAppValidator usernameAppValidator = UsernameAppValidator();

  bool isObsecure = true;
  bool isFormValid = false;
  bool isLoading = false;
  String? errorMessage;

  void validateForm() {
    // Update validator values
    usernameAppValidator.setValue(usernameController.text);
    passwordAppValidator.setValue(passwordController.text);

    // Check if all fields are filled
    bool allFieldsFilled = usernameController.text.isNotEmpty && 
                          passwordController.text.isNotEmpty;

    // Check if validators return no errors
    bool noValidationErrors = usernameAppValidator.check().isEmpty &&
                             passwordAppValidator.check().isEmpty;

    setState(() {
      isFormValid = allFieldsFilled && noValidationErrors;
      if (allFieldsFilled) {
        errorMessage = null; // Clear error when user starts typing
      }
    });
  }

  Future<void> _signIn() async {
    if (!isFormValid) return;

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      User? user = await _userController.authenticateUser(
        usernameController.text.trim(),
        passwordController.text,
      );

      if (mounted) {
        if (user != null) {
          // Authentication successful
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        } else {
          // Authentication failed
          setState(() {
            errorMessage = 'Wrong username or password';
            isFormValid = false;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          errorMessage = 'Authentication failed. Please try again.';
          isFormValid = false;
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
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
                Text("or use your username and password:"),
                SizedBox(height: 10),
                if (errorMessage != null) ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      border: Border.all(color: Colors.red.shade200),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.error_outline, color: Colors.red, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            errorMessage!,
                            style: TextStyle(color: Colors.red.shade700),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                ],
                AppTextField(
                  controller: usernameController,
                  validator: usernameAppValidator,
                  hint: 'Username',
                  prefixIcon: Icon(Icons.person),
                  onChange: (v) {
                    setState(() {
                      usernameAppValidator.setValue(v);
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
                  text: isLoading ? 'SIGNING IN...' : 'SIGN IN',
                  onPressed: (isFormValid && !isLoading) ? _signIn : null,
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
