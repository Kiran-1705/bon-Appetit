import 'dart:io';
import 'package:bon_appetit/database/model/user_model.dart';
import 'package:bon_appetit/screen/screen_sign.dart';
import 'package:bon_appetit/widget/SettingsWidgets/privacy_policy.dart';
import 'package:bon_appetit/widget/SettingsWidgets/settings_list_item.dart';
import 'package:bon_appetit/widget/SettingsWidgets/terms_and_conditions.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ScreenSettings extends StatefulWidget {
  const ScreenSettings({Key? key}) : super(key: key);

  @override
  State<ScreenSettings> createState() => _ScreenSettingsState();
}

class _ScreenSettingsState extends State<ScreenSettings> {
  final TextEditingController _updateNameController = TextEditingController();
  final TextEditingController _updatePhoneController = TextEditingController();
  final GlobalKey<FormState> _updateformkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(fontSize: 25, fontFamily: 'Righteous'),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildListItem('Account Settings', Icons.person, () {
              _showAccountSettingDialog(context);
            }),
            SizedBox(height: 10),
            buildListItem('Send Feedback', Icons.feedback, () {
              _showFeedbackDialog(context);
            }),
            SizedBox(height: 10),
            buildListItem('Follow us on LinkedIn', Icons.link, () {
              _openLinkedInProfile();
            }),
            SizedBox(height: 10),
            buildListItem('Privacy Policy', Icons.privacy_tip, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PrivacyPolicy()),
              );
            }),
            SizedBox(height: 10),
            buildListItem('Terms and Conditions', Icons.policy, () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TermsAndConditions(),
                ),
              );
            }),
            SizedBox(height: 10),
            buildListItem('About', Icons.info, () {
              showAboutDialog(
                context: context,
                applicationName: "bon Appetit",
                applicationIcon:
                    Image.asset('lib/assets/logo.png', width: 40, height: 40),
              );
            }),
          ],
        ),
      ),
      bottomNavigationBar: buildLogoutButton(),
    );
  }

  Widget buildLogoutButton() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Text(
            "Version 1.0.0+1",
            style: TextStyle(
                fontSize: 16, fontFamily: 'Kanit', color: Colors.grey),
          ),
        ),
        BottomAppBar(
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                _showLogoutConfirmationDialog(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  side: const BorderSide(color: Colors.black),
                ),
                padding: const EdgeInsets.all(16.0),
              ),
              child: const Text(
                'Logout',
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'RalewayVariableFont',
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor: Colors.black,
              title: const Text('Logout',
                  style: TextStyle(
                      fontFamily: 'Kanit', fontSize: 22, color: Colors.white)),
              content: const Text('Are you sure you want to logout?',
                  style: TextStyle(
                      fontFamily: 'Kanit', fontSize: 18, color: Colors.white)),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel',
                        style: TextStyle(
                            fontFamily: 'Kanit',
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                            color: Colors.white))),
                TextButton(
                    onPressed: () {
                      _signout(context);
                    },
                    child: const Text('Logout',
                        style: TextStyle(
                            fontFamily: 'Kanit',
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                            color: Colors.white))),
              ]);
        });
  }

  void _showFeedbackDialog(BuildContext context) {
    TextEditingController feedbackController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    String feedbackError = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Send Feedback',
                  style: TextStyle(
                    fontSize: 23,
                    fontFamily: 'RalewayVariableFont',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close),
                )
              ],
            ),
            content: const Text(
              'Let us know what you think about bon Appetit! We read all the feedback we receive and we would love to hear from you.',
              style: TextStyle(
                fontSize: 17,
                fontFamily: 'RalewayVariableFont',
                fontWeight: FontWeight.w700,
              ),
            ),
            actions: <Widget>[
              Column(
                children: [
                  TextFormField(
                    controller: feedbackController,
                    maxLines: 6,
                    decoration: InputDecoration(
                      labelText: 'Feedback',
                      labelStyle: const TextStyle(
                        fontFamily: 'RalewayVariableFont',
                        fontWeight: FontWeight.w700,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      errorText:
                          feedbackError.isNotEmpty ? feedbackError : null,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        String feedback = feedbackController.text;
                        // String email = emailController.text;

                        if (feedback.isNotEmpty) {
                          String mailtoLink =
                              'mailto:antonykiran1705@gmail.com?subject=Feedback&body=$feedback';
                          String encodedMailtoLink = Uri.encodeFull(mailtoLink);

                          // ignore: deprecated_member_use
                          if (await canLaunch(encodedMailtoLink)) {
                            // ignore: deprecated_member_use
                            await launch(encodedMailtoLink);
                            Navigator.of(context).pop();
                          } else {
                            print('Could not launch email client.');
                          }
                        } else {
                          setState(() {
                            feedbackError = 'Please fill the feedback session.';
                          });
                          print('Feedback cannot be empty.');
                        }
                      },
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
                          'Send feedback',
                          style: TextStyle(
                            fontSize: 23,
                            fontFamily: 'RalewayVariableFont',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAccountSettingDialog(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? loggedInUserEmail = prefs.getString('loggedInUserEmail');
    XFile? imageFile;
    if (loggedInUserEmail != null) {
      final userDB = Hive.box<UserModel>('user_db');
      final List<UserModel> userList = userDB.values.toList();

      final loggedInUser = userList.firstWhere(
        (user) => user.email == loggedInUserEmail,
        orElse: () => UserModel(name: '', email: '', phone: '', password: ''),
      );

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return AlertDialog(
                content: SingleChildScrollView(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Form(
                      key: _updateformkey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Update Profile',
                                style: TextStyle(
                                  fontSize: 23,
                                  fontFamily: 'RalewayVariableFont',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon: const Icon(Icons.close),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          InkWell(
                            onTap: () async {
                              final ImagePicker picker = ImagePicker();
                              XFile? image = await picker.pickImage(
                                source: ImageSource.gallery,
                              );
                              if (image != null) {
                                setState(() {
                                  imageFile = image;
                                });
                              }
                            },
                            child: CircleAvatar(
                              backgroundImage: imageFile != null
                                  ? FileImage(File(
                                      imageFile!.path,
                                    ))
                                  : null,
                              backgroundColor:
                                  imageFile == null ? Colors.black : null,
                              minRadius: 65,
                              child: imageFile == null
                                  ? const Icon(Icons.add_a_photo,
                                      color: Colors.white)
                                  : null,
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _updateNameController,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.person),
                              hintText: loggedInUser.name,
                              hintStyle: const TextStyle(
                                fontFamily: 'RalewayVariableFont',
                                fontWeight: FontWeight.w700,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return 'Please enter your name.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _updatePhoneController,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.phone),
                              hintText: loggedInUser.phone,
                              hintStyle: const TextStyle(
                                fontFamily: 'RalewayVariableFont',
                                fontWeight: FontWeight.w700,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return 'Please enter the Phone number';
                              } else if (value.length != 10) {
                                return 'Phone number must be exactly 10 digits.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_updateformkey.currentState!.validate()) {
                                  UserModel updatedUser = UserModel(
                                    name: _updateNameController.text,
                                    email: loggedInUser.email,
                                    phone: _updatePhoneController.text,
                                    password: loggedInUser.password,
                                    imagePath: imageFile?.path,
                                  );

                                  int userIndex =
                                      userList.indexOf(loggedInUser);
                                  userDB.putAt(userIndex, updatedUser);

                                  Navigator.of(context).pop();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Account Updated successfully',
                                        style: TextStyle(
                                          fontFamily: 'Kanit',
                                          fontSize: 15,
                                        ),
                                      ),
                                      backgroundColor: Colors.green,
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                }
                              },
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
                                  'Update',
                                  style: TextStyle(
                                    fontSize: 23,
                                    fontFamily: 'RalewayVariableFont',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      );
    }
  }

  void _signout(BuildContext ctx) async {
    final SharedPreferences sharedpref = await SharedPreferences.getInstance();
    await sharedpref.clear();

    Navigator.pushReplacement(
        ctx, MaterialPageRoute(builder: (ctx) => const ScreenSign()));
  }

  void _openLinkedInProfile() async {
    const String linkedInProfileUrl =
        'https://www.linkedin.com/in/antony-kiran-3345bb20b/';

    if (await canLaunchUrl(Uri.parse(linkedInProfileUrl))) {
      await launchUrl(Uri.parse(linkedInProfileUrl));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Failed to open LinkedIn profile',
            style: TextStyle(fontFamily: 'Kanit', fontSize: 15),
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
