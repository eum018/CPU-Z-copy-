import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final Widget child;
  final Widget? bottomBar;
  final PreferredSizeWidget? appBar;
  final Color backgroundColor;

  const DefaultLayout({
    super.key,
    required this.child,
    this.bottomBar,
    this.appBar,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: appBar,
        bottomNavigationBar: bottomBar,
        body: child,
      ),
    );
  }
}
