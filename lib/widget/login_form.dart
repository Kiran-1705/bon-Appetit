import 'package:bon_appetit/database/model/user_model.dart';
import 'package:bon_appetit/screen/admin/screen_adhome.dart';
import 'package:bon_appetit/screen/home/screen_home.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? emailErrorText;
  String? passwordErrorText;
  bool isPasswordVisible = false;
  bool isEmailValid = false;

  @override
  void initState() {
    super.initState();
    checkLoggedInUser();
  }

  void checkLoggedInUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? loggedInUserEmail = prefs.getString('loggedInUserEmail');

    if (loggedInUserEmail != null && loggedInUserEmail.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ScreenHome()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _emailController,
              onChanged: (value) {
                setState(() {
                  isEmailValid = EmailValidator.validate(value);
                  emailErrorText = isEmailValid ? null : 'Enter a valid email';
                });
              },
              validator: (_) => emailErrorText,
              decoration: InputDecoration(
                errorText: emailErrorText,
                errorStyle: const TextStyle(
                    fontFamily: 'RalewayVariableFont',
                    fontWeight: FontWeight.w700),
                prefixIcon: const Icon(Icons.email_outlined),
                labelText: 'Email',
                labelStyle: const TextStyle(
                    fontFamily: 'RalewayVariableFont',
                    fontWeight: FontWeight.w700),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              obscureText: !isPasswordVisible,
              controller: _passwordController,
              onChanged: (value) {
                setState(() {
                  passwordErrorText = value.isEmpty ? 'Enter password' : null;
                });
              },
              validator: (_) => passwordErrorText,
              decoration: InputDecoration(
                errorText: passwordErrorText,
                errorStyle: const TextStyle(
                    fontFamily: 'RalewayVariableFont',
                    fontWeight: FontWeight.w700),
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                ),
                labelText: 'Password',
                labelStyle: const TextStyle(
                    fontFamily: 'RalewayVariableFont',
                    fontWeight: FontWeight.w700),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _handleLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Login',
                    style: TextStyle(
                        fontSize: 23,
                        fontFamily: 'RalewayVariableFont',
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Forgot Password?',
                style: TextStyle(
                    fontSize: 19,
                    fontFamily: 'RalewayVariableFont',
                    fontWeight: FontWeight.w700),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ScreenAdminHome(),
                  ),
                );
              },
              child: const Text('Admin'),
            ),
          ],
        ),
      ),
    );
  }

  void _handleLogin() async {
    final enteredEmail = _emailController.text.trim();
    final enteredPassword = _passwordController.text.trim();

    if (_formKey.currentState?.validate() ?? false) {
      final userDB = await Hive.openBox<UserModel>('user_db');
      final userList = userDB.values.toList();

      final user = userList.firstWhere(
        (user) =>
            user.email == enteredEmail && user.password == enteredPassword,
        orElse: () => UserModel(
          name: '',
          email: '',
          password: '',
          phone: '',
        ),
      );
      if (user.email.isNotEmpty && user.password.isNotEmpty) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('loggedInUserEmail', enteredEmail);

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const ScreenHome(),
            ));
      } else {
        setState(() {
          emailErrorText = 'Email and password do not match';
          passwordErrorText = 'Email and password do not match';
        });
      }
    }
  }
}
