import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio/apps/radio/controller/cubit/station_cubit.dart';
import 'package:radio/apps/radio/services/repository/radio_repository.dart';
import 'package:radio/apps/radio/views/schedule/radio_line_up_card.dart';

class DailyScheduleComponent extends StatefulWidget {
  final String day;

  const DailyScheduleComponent({
    Key? key,
    required this.day,
  }) : super(key: key);

  @override
  State<DailyScheduleComponent> createState() => _DailyScheduleComponentState();
}

class _DailyScheduleComponentState extends State<DailyScheduleComponent>
    with TickerProviderStateMixin {
  StationCubit? _bloc;
  AnimationController? animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    _bloc = StationCubit(RadioRepository());
    _bloc?.fetchStation();
  }

  @override
  void dispose() {
    _bloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StationCubit, StationState>(
      bloc: _bloc,
      builder: (_, state) {
        if (state is StationLoaded) {
          final day = state.data.schedule!.getScheduleByDay(widget.day);
          return day.isEmpty
              ? const Center(child: Text("No Show Scheduled This Day"))
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
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
                        day: day[index],
                      ),
                    );
                  },
                );
        }

        if (state is StationLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is StationEmpty) {
          return const Center(child: Text("No Show Scheduled for this Day"));
        }
        if (state is StationError) {
          return const Center(child: Text("No Show Scheduled for this Day"));
        }

        return const Center(child: Text("No Show Scheduled for this Day"));
      },
    );
  }
}
