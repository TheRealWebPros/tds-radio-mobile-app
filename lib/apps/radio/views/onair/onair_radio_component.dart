import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio/apps/radio/controller/cubit/station_cubit.dart';
import 'package:radio/apps/radio/services/repository/radio_repository.dart';
import 'package:radio/apps/radio/views/onair/on_air_header.dart';

class OnairRadioComponent extends StatefulWidget {
  const OnairRadioComponent({Key? key}) : super(key: key);

  @override
  State<OnairRadioComponent> createState() => _OnairRadioComponentState();
}

class _OnairRadioComponentState extends State<OnairRadioComponent> {
  StationCubit? _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = StationCubit(RadioRepository());
    _bloc
        ?.fetchStation(); // Fetch the station data when the widget is initialized
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
          final currentShow = state.data.broadcast!.currentShow;
          return Column(
            children: [
              const SizedBox(
                height: 0,
              ),
              currentShow == null
                  ? const SizedBox(
                      height: 0,
                    )
                  : OnAirHeader(
                      currentShow: currentShow,
                    ),
              const SizedBox(
                height: 10,
              ),
            ],
          );
        } else if (state is StationLoading) {
          return Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              OnAirHeader.shimmer(),
              const SizedBox(
                height: 10,
              ),
            ],
          );
        }

        // else if (state is StationError) {
        //   return const SizedBox(
        //     height: 0,
        //   );
        // }

        else {
          return const SizedBox(
            height: 0,
          );
        }
      },
    );
  }
}
