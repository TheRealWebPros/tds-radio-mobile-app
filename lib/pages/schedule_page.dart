import 'package:flutter/material.dart';
import 'package:radio/apps/radio/views/schedule/daily_schedule_component.dart';
import 'package:radio/helpers/constant/app_styles.dart';

import '../responsive.dart';
import '../apps/radio/views/schedule/tab_sliver_delegate.dart';

class SchedulePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const SchedulePage({Key? key, required this.scaffoldKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    final List<String> tabs = <String>[
      'Mon',
      'Tue',
      'Wed',
      'Thur',
      'Fri',
      'Sat',
      'Sun',
    ];
    return SizedBox(
      child: DefaultTabController(
        length: tabs.length,
        initialIndex: date.weekday - 1,
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar.large(
                automaticallyImplyLeading: true,
                centerTitle: false,
                backgroundColor: appBarbg,
                elevation: 0,
                title: const Text("Weekly Schedule"),
                leading: Builder(
                  builder: (context) => IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: Responsive.isMobile(context) ? 5 : 18,
                ),
              ),
              SliverPersistentHeader(
                floating: true,
                delegate: TabSliverDelegate(TabBar(
                  isScrollable: true,
                  labelColor: kGrey85, // Set the selected text color to red

                  indicatorColor: kGrey85,
                  unselectedLabelColor: kWhite,
                  tabs: tabs
                      .map((e) => Tab(
                            child: Text(
                              e,
                            ),
                          ))
                      .toList(),
                )),
                pinned: true,
              ),
            ];
          },
          body: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            child: TabBarView(
              children: [
                DailyScheduleComponent(
                  day: 'Monday',
                ),
                DailyScheduleComponent(
                  day: 'Tuesday',
                ),
                DailyScheduleComponent(
                  day: 'Wednesday',
                ),
                DailyScheduleComponent(
                  day: 'Thursday',
                ),
                DailyScheduleComponent(
                  day: 'Friday',
                ),
                DailyScheduleComponent(
                  day: 'Saturday',
                ),
                DailyScheduleComponent(
                  day: 'Sunday',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
