import 'dart:io';
import 'package:bon_appetit/database/model/user_model.dart';
import 'package:bon_appetit/widget/signup_form.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenSettings extends StatefulWidget {
  const ScreenSettings({Key? key}) : super(key: key);

  @override
  State<ScreenSettings> createState() => _ScreenSettingsState();
}

class _ScreenSettingsState extends State<ScreenSettings> {
  final TextEditingController _updateNameController = TextEditingController();
  final TextEditingController _updatePhoneController = TextEditingController();
  final TextEditingController _updateEmailController = TextEditingController();
  final GlobalKey<FormState> _updateformkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'S e t t i n g s',
          style: TextStyle(fontSize: 25, fontFamily: 'Righteous'),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                _showLogoutConfirmationDialog(context);
              },
              icon: const Icon(
                Icons.logout,
                size: 30,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () {
                      _showAccountSettingDialog(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Account Settings',
                          style: TextStyle(
                              fontSize: 21,
                              fontFamily: 'Kanit',
                              color: Colors.black),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.arrow_forward,
                              color: Colors.black),
                        )
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Share the App',
                          style: TextStyle(
                              fontSize: 21,
                              fontFamily: 'Kanit',
                              color: Colors.black),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.share, color: Colors.black),
                        )
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _showFeedbackDialog(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Send Feedback',
                          style: TextStyle(
                              fontSize: 21,
                              fontFamily: 'Kanit',
                              color: Colors.black),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon:
                                const Icon(Icons.feedback, color: Colors.black))
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Follow us on LinkedIn',
                          style: TextStyle(
                              fontSize: 21,
                              fontFamily: 'Kanit',
                              color: Colors.black),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.link, color: Colors.black),
                        )
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'About',
                          style: TextStyle(
                              fontSize: 21,
                              fontFamily: 'Kanit',
                              color: Colors.black),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.info, color: Colors.black),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () {},
              child: const Text(
                'Privacy Policy',
                style: TextStyle(
                    fontSize: 21, fontFamily: 'Kanit', color: Colors.black),
              ),
            ),
            const Text(
              '|',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Terms of Use',
                style: TextStyle(
                    fontSize: 21, fontFamily: 'Kanit', color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout',
              style: TextStyle(fontFamily: 'Kanit', fontSize: 22)),
          content: const Text('Are you sure you want to logout?',
              style: TextStyle(fontFamily: 'Kanit', fontSize: 18)),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                    fontFamily: 'Kanit',
                    fontWeight: FontWeight.w400,
                    fontSize: 20),
              ),
            ),
            TextButton(
              onPressed: () {
                _signout(context);
              },
              child: const Text(
                'Logout',
                style: TextStyle(
                    fontFamily: 'Kanit',
                    fontWeight: FontWeight.w400,
                    fontSize: 20),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showFeedbackDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Send Feedback',
                style: TextStyle(
                    fontSize: 23,
                    fontFamily: 'RalewayVariableFont',
                    fontWeight: FontWeight.w700),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close))
            ],
          ),
          content: const Text(
            'Let us know what you think about bon Appetit! We read all the feedback we receive and we would love to hear from you.',
            style: TextStyle(
                fontSize: 17,
                fontFamily: 'RalewayVariableFont',
                fontWeight: FontWeight.w700),
          ),
          actions: <Widget>[
            Column(
              children: [
                TextFormField(
                  maxLines: 6,
                  decoration: InputDecoration(
                    labelText: 'Feedback',
                    labelStyle: const TextStyle(
                        fontFamily: 'RalewayVariableFont',
                        fontWeight: FontWeight.w700),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email(Optional)',
                    labelStyle: const TextStyle(
                        fontFamily: 'RalewayVariableFont',
                        fontWeight: FontWeight.w700),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
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
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
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
        orElse: () => UserModel(
          name: '',
          email: '',
          phone: '',
          password: '',
        ),
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
                                  ? FileImage(
                                      File(
                                        imageFile!.path,
                                      ),
                                    )
                                  : null,
                              backgroundColor:
                                  imageFile == null ? Colors.black : null,
                              minRadius: 65,
                              child: imageFile == null
                                  ? const Icon(
                                      Icons.add_a_photo,
                                      color: Colors.white,
                                    )
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
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _updateEmailController,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.email_outlined),
                              hintText: loggedInUser.email,
                              hintStyle: const TextStyle(
                                fontFamily: 'RalewayVariableFont',
                                fontWeight: FontWeight.w700,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
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
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                UserModel updatedUser = UserModel(
                                  name: _updateNameController.text,
                                  email: _updateEmailController.text,
                                  phone: _updatePhoneController.text,
                                  password: loggedInUser.password,
                                  imagePath: imageFile?.path,
                                );

                                int userIndex = userList.indexOf(loggedInUser);
                                userDB.putAt(userIndex, updatedUser);

                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Account Updated successfully',
                                      style: TextStyle(
                                          fontFamily: 'Kanit', fontSize: 15),
                                    ),
                                    backgroundColor: Colors.green,
                                    duration: Duration(seconds: 2),
                                  ),
                                );
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
    Navigator.of(ctx).pushReplacement(
      MaterialPageRoute(builder: (ctx) => const ScreenSignup()),
    );
  }
}
