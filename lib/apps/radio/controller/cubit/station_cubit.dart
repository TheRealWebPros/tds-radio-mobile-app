import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:radio/apps/radio/services/repository/radio_repository.dart';

import '../../model/station.dart';

part 'station_state.dart';

class StationCubit extends Cubit<StationState> {
  StationCubit(this._repository) : super(StationInitial());

  final RadioRepository _repository;

  void fetchStation() async {
    try {
      emit(
        StationLoading(),
      );
      final station = await _repository.fetchStation();

      if (isClosed) return;

      emit(
        StationLoaded(data: station),
      );
    } catch (e) {
      emit(
        StationError(error: e.toString()),
      );
    }
  }

  Future<void> fetchTodaySchedule(String day) async {
    try {
      emit(
        StationLoading(),
      );
      final station = await _repository.fetchStation();

      if (isClosed) return;

      //  if (station.schedule!.getScheduleByDay("day").isNotEmpty) {
      //   emit(
      //     StationLoaded(data: station),
      //   );
      // }

      emit(
        StationLoaded(
          data: station,
        ),
      );
    } catch (e) {
      emit(
        StationError(error: e.toString()),
      );
    }
  }
}
