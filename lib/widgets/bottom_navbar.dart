import 'package:flutter/material.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {},
              child: Text(
                "Terms & Condition",
                style: TextStyle(
                  color: Colors.black54,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            Text('|', style: TextStyle(color: Colors.black45)),
            TextButton(
              onPressed: () {},
              child: Text(
                "Privacy Policy",
                style: TextStyle(
                  color: Colors.black54,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}