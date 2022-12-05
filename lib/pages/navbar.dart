import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: SidebarXController(selectedIndex: 0, extended: true),
      theme: SidebarXTheme(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: canvasColor,
          borderRadius: BorderRadius.circular(20),
        ),
        hoverColor: scaffoldBackgroundColor,
        textStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
        selectedTextStyle: const TextStyle(color: Colors.white),
        itemTextPadding: const EdgeInsets.only(left: 30),
        selectedItemTextPadding: const EdgeInsets.only(left: 30),
        itemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: canvasColor),
        ),
        selectedItemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: actionColor.withOpacity(0.37),
          ),
          gradient: const LinearGradient(
            colors: [accentCanvasColor, canvasColor],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.28),
              blurRadius: 30,
            )
          ],
        ),
        iconTheme: IconThemeData(
          color: Colors.white.withOpacity(0.7),
          size: 20,
        ),
        selectedIconTheme: const IconThemeData(
          color: Colors.white,
          size: 20,
        ),
      ),
      extendedTheme: const SidebarXTheme(
        width: 200,
        decoration: BoxDecoration(
          color: canvasColor,
        ),
      ),
      footerDivider: divider,
      headerBuilder: (context, extended) {
        return SizedBox(
          height: 120,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset('assets/main_icon.png'),
          ),
        );
      },
      items: [
        SidebarXItem(
          icon: Icons.home,
          label: 'হোম',
          onTap: () {
            Navigator.pushNamed(context, '/main_menu');
          },
        ),
        SidebarXItem(
          icon: Icons.info,
          label: 'ব্যবহার বিধি',
          onTap: () {
            Navigator.pushNamed(context, '/manual1');
          },
        ),
        SidebarXItem(
          icon: Icons.settings,
          label: 'সেটিংস',
          onTap: () {
            Navigator.pushNamed(context, '/settings');
          },
        ),
        SidebarXItem(
          icon: Icons.logout,
          label: 'সাইন আউট',
          onTap: () {
            Navigator.pushNamed(context, '/home');
          },
        ),
      ],
    );
  }
}


const primaryColor = Color(0xFF685BFF);
const canvasColor = Color(0xFF12425C); //this
const scaffoldBackgroundColor = Color(0xFF464667);
const accentCanvasColor = Color(0xFF0277BD); //this
const white = Colors.white;
final actionColor = const Color(0xFF5F5FA7).withOpacity(0.6);
final divider = Divider(color: white.withOpacity(0.3), height: 1);