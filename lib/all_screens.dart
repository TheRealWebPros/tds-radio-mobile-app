import 'package:flutter/material.dart';
import 'package:radio/pages/posts_list_page.dart';
import 'package:radio/pages/schedule_page.dart';
import 'package:radio/main_layout.dart';
import 'package:radio/pages/home_page.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      scaffoldKey: _scaffoldKey,
      child: HomePage(scaffoldKey: _scaffoldKey),
    );
  }
}

class ScheduleScreen extends StatelessWidget {
  ScheduleScreen({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      scaffoldKey: _scaffoldKey,
      child: SchedulePage(scaffoldKey: _scaffoldKey),
    );
  }
}

class PostScreen extends StatelessWidget {
  PostScreen({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      scaffoldKey: _scaffoldKey,
      child: PostsPageList(scaffoldKey: _scaffoldKey),
    );
  }
}
