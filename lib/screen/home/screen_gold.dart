import 'package:bon_appetit/widget/faq.dart';
import 'package:flutter/material.dart';

class ScreenGold extends StatelessWidget {
  const ScreenGold({super.key});

  Widget buildRow(
      {required IconData icon,
      required String text,
      required String popupMenuText}) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Icon(icon, color: Colors.yellow, size: 30),
      Text(text,
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Kanit',
              fontWeight: FontWeight.w700)),
      PopupMenuButton<String>(
          onSelected: (String result) {},
          icon: Icon(Icons.info, color: Colors.yellow, size: 30),
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                    value: 'info',
                    child: Text(popupMenuText,
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Kanit',
                            fontWeight: FontWeight.w700))),
              ]),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Unlock the full features with',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontFamily: 'Kanit',
                            fontWeight: FontWeight.w700)),
                    Text('bon\nAppetit\nGold.',
                        style: TextStyle(
                            fontSize: 35,
                            fontFamily: 'RalewayVariableFont',
                            fontWeight: FontWeight.w700,
                            color: Colors.yellow)),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 10),
                child: Column(
                  children: [
                    buildRow(
                      icon: Icons.all_inclusive,
                      text: 'Upload unlimited Recipes',
                      popupMenuText:
                          'You can add as many recipes as you desire.',
                    ),
                    SizedBox(height: 10),
                    buildRow(
                      icon: Icons.edit,
                      text: 'Modify Recipes',
                      popupMenuText:
                          'Feel free to edit as many recipes as you desire.',
                    ),
                    SizedBox(height: 10),
                    buildRow(
                      icon: Icons.favorite,
                      text: 'Support our Team',
                      popupMenuText:
                          "We don't show any ads, so we depend on supporters like you to keep us running.",
                    ),
                    SizedBox(height: 10),
                    buildRow(
                      icon: Icons.thumb_up,
                      text: 'Get Priority Support',
                      popupMenuText:
                          'Get lightning-fast responses from our support team when you have questions or feedback.',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
              FaqSection(),
            ],
          ),
        ),
      ),
    );
  }
}
