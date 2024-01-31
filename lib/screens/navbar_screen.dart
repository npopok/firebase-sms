import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavbarScreen extends StatefulWidget {
  final Widget child;

  const NavbarScreen({required this.child, super.key});

  @override
  State<NavbarScreen> createState() => _NavbarScreenState();
}

class _NavbarScreenState extends State<NavbarScreen> {
  int currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: SizedBox(
        height: 75,
        child: BottomNavigationBar(
          iconSize: 20,
          currentIndex: currentTab,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.grid_view),
              label: 'HomeScreen.ProjectsTab'.tr(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person),
              label: 'HomeScreen.AccountTab'.tr(),
            ),
          ],
          onTap: (value) {
            if (value != currentTab && value == 0) context.go('/projects');
            if (value != currentTab && value == 1) context.push('/account');
            setState(() => currentTab = value);
          },
        ),
      ),
    );
  }
}
