// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FaqItem extends StatelessWidget {
  final String question;
  final String answer;
  final String? email;

  const FaqItem({
    Key? key,
    required this.question,
    required this.answer,
    this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'Kanit',
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          answer,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontFamily: 'Kanit',
            fontWeight: FontWeight.w400,
          ),
        ),
        if (email != null)
          GestureDetector(
            onTap: () => _launchEmail(email!),
            child: Text(
              email!,
              style: TextStyle(
                color: Colors.blue,
                fontSize: 15,
                fontFamily: 'Kanit',
                fontWeight: FontWeight.w400,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        SizedBox(height: 20),
      ],
    );
  }

  _launchEmail(String email) async {
    final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    if (await canLaunch(_emailLaunchUri.toString())) {
      await launch(_emailLaunchUri.toString());
    } else {
      throw 'Could not launch $_emailLaunchUri';
    }
  }
}

class FaqSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Frequently Asked Questions',
            style: TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontFamily: 'Kanit',
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 20),
          FaqItem(
            question: 'Can I easily cancel my membership ?',
            answer:
                "We don't hide the option to cancel like other apps do. You can easily end your subscription at any time.",
          ),
          FaqItem(
            question: 'Will my membership work on all my devices ?',
            answer: "No, the membership will be local for every device.",
          ),
          FaqItem(
            question: 'How do I know my payment information is safe ?',
            answer:
                "Payments are done securely by the Amazon App Store or App Store. Your sensitive payment information is never visible to us or anyone else.",
          ),
          FaqItem(
            question: 'Still have questions ?',
            answer: "We'd be happy to answer them! You can contact us at ",
            email: 'antonykiran1705@gmail.com',
          ),
        ],
      ),
    );
  }
}
