import 'package:bon_appetit/database/db_function.dart';
import 'package:bon_appetit/database/model/user_model.dart';
import 'package:bon_appetit/screen/screen_start.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class ScreenSignup extends StatefulWidget {
  const ScreenSignup({super.key});

  @override
  State<ScreenSignup> createState() => _ScreenSignupState();
}

class _ScreenSignupState extends State<ScreenSignup> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _usernameError;
  String? _emailError;
  String? _phoneError;
  String? _passwordError;
  bool _obscurePassword = true;
  void _validateUsername(String value) {
    setState(() {
      if (value.isEmpty) {
        _usernameError = 'Please enter your username.';
      } else if (value.trim().length < 5) {
        _usernameError = 'Username must be at least 5 characters.';
      } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
        _usernameError = 'Username can only contain letters.';
      } else {
        _usernameError = null;
      }
    });
  }

  void _validateEmail(String value) {
    setState(() {
      if (value.isNotEmpty && !EmailValidator.validate(value)) {
        _emailError = 'Please enter a valid email address.';
      } else {
        _emailError = null;
      }
    });
  }

  void _validatePhone(String value) {
    setState(() {
      if (value.isNotEmpty && value.length != 10) {
        _phoneError = 'Invalid phone number';
      } else {
        _phoneError = null;
      }
    });
  }

  void _validatePassword(String value) {
    setState(() {
      if (value.length < 4 ||
          !RegExp(r'^(?=.*?[A-Za-z])(?=.*?[0-9].*?[0-9])(?=.*?[!@#$%^&*]).{4,}$')
              .hasMatch(value)) {
        _passwordError = 'Password must have 1 special character and 2 digits.';
      } else {
        _passwordError = null;
      }
    });
  }

  void _confirmPassword(String value) {
    setState(() {
      if (value != _passwordController.text) {
        _passwordError = 'Passwords do not match.';
      } else {
        _passwordError = null;
      }
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final UserModel newUser = UserModel(
        name: _usernameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        password: _passwordController.text,
      );
      addUser(newUser);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const ScreenStart()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.person),
                  labelText: 'Username',
                  errorText: _usernameError,
                ),
                onChanged: _validateUsername,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.email),
                  labelText: 'Email',
                  errorText: _emailError,
                ),
                onChanged: _validateEmail,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.phone),
                  labelText: 'Phone',
                  errorText: _phoneError,
                ),
                onChanged: _validatePhone,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.lock),
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(_obscurePassword
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  hintText:
                      'Password requires 1 special character and any 2 digits',
                  errorText: _passwordError,
                ),
                onChanged: _validatePassword,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.lock),
                  labelText: 'Confirm Password',
                  suffixIcon: IconButton(
                    icon: Icon(_obscurePassword
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  errorText: _passwordError,
                ),
                onChanged: _confirmPassword,
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _submitForm(),
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
                      'Submit',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
