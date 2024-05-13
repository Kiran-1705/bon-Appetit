import 'package:flutter/material.dart';
import 'package:bon_appetit/screen/home/screen_gold.dart';

class JoinGoldButton extends StatelessWidget {
  const JoinGoldButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 345,
        child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ScreenGold()),
              );
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                minimumSize: const Size(double.infinity, 50)),
            child: const Padding(
                padding: EdgeInsets.all(16.0),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(Icons.workspace_premium, size: 30),
                  Text('Join bon Appetit Gold',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'RalewayVariableFont',
                          fontWeight: FontWeight.w700)),
                ]))));
  }
}
