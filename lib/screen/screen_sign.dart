import 'package:bon_appetit/widget/login_form.dart';
import 'package:bon_appetit/widget/signup_form.dart';
import 'package:bon_appetit/widget/tab_button.dart';
import 'package:flutter/material.dart';

class ScreenSign extends StatefulWidget {
  const ScreenSign({super.key});

  @override
  State<ScreenSign> createState() => _ScreenSignState();
}

class _ScreenSignState extends State<ScreenSign> {
  int selectedTabIndex = 0;
  bool showSignUpContainer = false;
  bool showSignInContainer = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 280,
                    child: Center(
                      child: Image.asset(
                        'lib/assets/title.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 200,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: SizedBox(
                      height: 100,
                      width: 300,
                      child: Row(
                        children: [
                          TabButtons(selectedTabIndex, 1, 'Signup', (index) {
                            setState(() {
                              selectedTabIndex = index;
                              showSignUpContainer = true;
                              showSignInContainer = false;
                            });
                          }),
                          TabButtons(selectedTabIndex, 0, 'Login', (index) {
                            setState(() {
                              selectedTabIndex = index;
                              showSignInContainer = true;
                              showSignUpContainer = false;
                            });
                          }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: showSignUpContainer,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ScreenSignup(),
                ),
              ),
              Visibility(
                visible: showSignInContainer,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SignInForm(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
