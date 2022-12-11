import 'package:flutter/material.dart';

class Control_Panel_Full extends StatefulWidget {
  @override
  _Control_Panel_FullState createState() => _Control_Panel_FullState();
}

class _Control_Panel_FullState extends State<Control_Panel_Full> {
  Map args = {};
  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)?.settings.arguments as Map;
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/livefeedrotated.png'),
              fit: BoxFit.fill,
            )
        ),

      ),
    );
  }
}
