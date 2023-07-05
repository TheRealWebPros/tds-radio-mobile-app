import 'package:flutter/material.dart';
import 'package:radio/apps/radio/views/player/player_component.dart';
import 'package:radio/responsive.dart';
import 'package:radio/widgets/menu.dart';
import 'package:radio/widgets/right_sidebar.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({
    Key? key,
    required this.scaffoldKey,
    required this.child,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Responsive.isMobile(context)
          ? const SafeArea(
              child: PlayerComponent(),
            )
          : null,
      key: scaffoldKey,
      drawer: !Responsive.isDesktop(context)
          ? SizedBox(width: 250, child: Menu(scaffoldKey: scaffoldKey))
          : null,
      body: SafeArea(
        child: Row(
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                flex: 3,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Menu(scaffoldKey: scaffoldKey),
                ),
              ),
            Expanded(
              flex: 8,
              child: child,
            ),
            if (!Responsive.isMobile(context))
              const Expanded(
                flex: 4,
                child: RightSidebar(),
              ),
          ],
        ),
      ),
    );
  }
}
