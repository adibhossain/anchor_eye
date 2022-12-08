import 'package:flutter/material.dart';

class ControlPanel extends StatefulWidget {
  @override
  _ControlPanelState createState() => _ControlPanelState();
}

class _ControlPanelState extends State<ControlPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFB9E6FA),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Image.asset('assets/refresh.png'),
                    iconSize: 20,
                    onPressed: () {},
                  ),
                  SizedBox(width: 230),
                  IconButton(
                    icon: Image.asset('assets/help.png'),
                    iconSize: 20,
                    onPressed: () {},
                  ),
                ],
              ),
              Image(
                image: AssetImage('assets/livefeed.png'),
                height: 200.0,
                width: 300.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Image(
                    image: AssetImage('assets/battery-icon.png'),
                  ),
                  IconButton(
                    icon: Image.asset('assets/power-off.png'),
                    iconSize: 50,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  IconButton(
                    icon: Image.asset('assets/full-screen-icon.png'),
                    iconSize: 20,
                    onPressed: () {},
                  ),
                ],
              ),
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Image.asset('assets/rotate-left.png'),
                    iconSize: 20,
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Image.asset('assets/rotate-right.png'),
                    iconSize: 20,
                    onPressed: () {},
                  ),
                  SizedBox(width: 140),
                  IconButton(
                    icon: Image.asset('assets/rod.png'),
                    iconSize: 70,
                    onPressed: () {},
                  ),
                ],
              ),
              SizedBox(height: 25),
              IconButton(
                icon: Image.asset('assets/up.png'),
                iconSize: 50,
                onPressed: () {},
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Image.asset('assets/left.png'),
                    iconSize: 50,
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Image.asset('assets/stop.png'),
                    iconSize: 50,
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Image.asset('assets/right.png'),
                    iconSize: 50,
                    onPressed: () {},
                  ),
                ],
              ),
              IconButton(
                icon: Image.asset('assets/down.png'),
                iconSize: 50,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
