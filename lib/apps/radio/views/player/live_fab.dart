import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio/apps/radio/bloc/radio_bloc.dart';
import 'package:radio/apps/radio/controller/cubit/station_cubit.dart';
import 'package:radio/apps/radio/services/repository/radio_repository.dart';
import 'package:radio/helpers/constant/app_styles.dart';

class LiveFab extends StatefulWidget {
  const LiveFab({Key? key}) : super(key: key);

  @override
  State<LiveFab> createState() => _LiveFabState();
}

class _LiveFabState extends State<LiveFab> {
  StationCubit? _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = StationCubit(RadioRepository());
    _bloc?.fetchStation();
  }

  @override
  Widget build(BuildContext context) {
    final blocRadio = context.read<RadioBloc>();

    return BlocBuilder<StationCubit, StationState>(
      bloc: _bloc,
      builder: (_, state) {
        if (kDebugMode) {
          print("$state.............................");
        }
        if (state is StationLoaded) {
          return Row(
            children: [
              FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: () {
                  blocRadio.play(state.data);
                },
                child: const Icon(
                  Icons.play_arrow_sharp,
                  color: Colors.red,
                ),
              ),
            ],
          );
        }

        return Row(
          children: [
            FloatingActionButton(
              backgroundColor: kWhite,
              onPressed: () {},
              child: const CircularProgressIndicator(
                color: kGrey8E,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _bloc?.close();
    super.dispose();
  }
}
