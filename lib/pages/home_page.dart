import 'package:flutter/material.dart';
import 'package:radio/apps/news_posts/view/post_component.dart';
import 'package:radio/apps/news_posts/view/post_header_component.dart';
import 'package:radio/apps/radio/views/onair/onair_radio_component.dart';
import 'package:radio/apps/radio/views/schedule/today.dart';
import 'package:radio/config.dart';
import 'package:radio/responsive.dart';
import 'package:radio/widgets/header_widget.dart';

class HomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const HomePage({super.key, required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height,
        child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                Header(
                  scaffoldKey: scaffoldKey,
                  title: Config.appName,
                ),
              ];
            },
            body: CustomScrollView(
              slivers: <Widget>[
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: OnairRadioComponent(),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: Responsive.isMobile(context) ? 5 : 18,
                  ),
                ),
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TodayScheduleComponent(),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: PostHeaderComponent(),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: PostComponent(
                      count: 5,
                    ),
                  ),
                ),
              ],
            )));
  }
}
