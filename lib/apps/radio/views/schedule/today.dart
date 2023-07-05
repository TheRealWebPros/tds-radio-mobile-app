import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:radio/apps/radio/controller/cubit/station_cubit.dart';
import 'package:radio/apps/radio/model/station.dart';
import 'package:radio/apps/radio/services/repository/radio_repository.dart';
import 'package:radio/apps/radio/views/schedule/radio_line_up_card.dart';
import 'package:radio/all_screens.dart';
import 'package:radio/helpers/constant/app_styles.dart';
import 'package:radio/responsive.dart';

class TodayScheduleComponent extends StatefulWidget {
  const TodayScheduleComponent({Key? key}) : super(key: key);

  @override
  State<TodayScheduleComponent> createState() => _TodayScheduleComponentState();
}

class _TodayScheduleComponentState extends State<TodayScheduleComponent>
    with TickerProviderStateMixin {
  StationCubit? _bloc;
  AnimationController? animationController;
  late DateTime today;
  late String dayOfWeek;
  @override
  void initState() {
    today = DateTime.now();
    dayOfWeek = DateFormat('EEEE').format(today);

    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    _bloc = StationCubit(RadioRepository());
    _bloc?.fetchTodaySchedule(
        dayOfWeek); // Fetch the station data when the widget is initialized
  }

  @override
  void dispose() {
    _bloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StationCubit, StationState>(
      bloc: _bloc, // Pass the cubit instance to the BlocBuilder
      builder: (context, state) {
        if (state is StationLoaded) {
          List<Day> day = state.data.schedule!.getScheduleByDay(dayOfWeek);

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "$dayOfWeek's Line-Up",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: titleStyle,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    ScheduleScreen(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                      child: Text(
                        "View All",
                        style: subtitleStyle,
                      ),
                    ),
                  ],
                ),
              ),
              day.isEmpty
                  ? const Center(child: Text("No Show Scheduled This Day"))
                  : Responsive.isDesktop(context)
                      ? GridView.builder(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 160,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 10,
                            mainAxisExtent: 200,
                          ),
                          itemCount: day.length,
                          itemBuilder: (context, index) {
                            final int count = day.length > 10 ? 10 : day.length;
                            final Animation<double> animation =
                                Tween<double>(begin: 0.0, end: 1.0).animate(
                              CurvedAnimation(
                                parent: animationController!,
                                curve: Interval((1 / count) * index, 1.0,
                                    curve: Curves.fastOutSlowIn),
                              ),
                            );
                            animationController?.forward();
                            return InkWell(
                              onTap: () {},
                              child: LineUpCard(
                                animation: animation,
                                animationController: animationController,
                                day: day[
                                    index], // Pass the specific day to NewLineUpItem
                              ),
                            );
                          },
                        )
                      : SizedBox(
                          height: 200,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: day.length,
                            itemBuilder: (BuildContext context, int index) {
                              final int count =
                                  day.length > 10 ? 10 : day.length;
                              final Animation<double> animation =
                                  Tween<double>(begin: 0.0, end: 1.0).animate(
                                      CurvedAnimation(
                                          parent: animationController!,
                                          curve: Interval(
                                              (1 / count) * index, 1.0,
                                              curve: Curves.fastOutSlowIn)));
                              animationController?.forward();
                              return InkWell(
                                onTap: () {},
                                child: LineUpCard(
                                  animation: animation,
                                  animationController: animationController,
                                  day: day[
                                      index], // Pass the specific day to NewLineUpItem
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const SizedBox(
                              width: 16,
                            ),
                          ),
                        ),
            ],
          );
        }
        if (state is StationError) {
          if (kDebugMode) {
            print(state.error);
          }
          return const SizedBox(
            height: 0,
          );
        }
        return const SizedBox(
          height: 0,
        );
      },
    );
  }
}
