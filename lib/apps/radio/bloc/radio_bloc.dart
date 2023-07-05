import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:radio/apps/radio/bloc/radio_state.dart';
import 'package:radio/apps/radio/common.dart';
import 'package:radio/apps/radio/model/station.dart';
import 'package:radio/apps/radio/services/repository/radio_repository.dart';
import 'package:rxdart/rxdart.dart';

class RadioBloc extends Cubit<RadioState> {
  static const String playerEventChannel = "playerActions";
  static int _nextMediaId = 2;

  RadioRepository repository;
  Station _current = Station();

  final _audioPlayer = AudioPlayer();

  bool _isLoaded = false;

  RadioBloc({required this.repository}) : super(InitialState()) {
    audioEvents();
    // notificationEvents();
  }

  // functions

  void audioEvents() {
    _audioPlayer.playerStateStream.listen((event) {
      switch (event.processingState) {
        case ProcessingState.loading:
          emit(LoadingState(_current));
          _isLoaded = false;
          break;
        case ProcessingState.ready:
          emit(PlayingState(
            event.playing,
            _current,
          ));

          if (_isLoaded) {
            // NotificationHelper.notifyPlayState(event.playing);
          } else {
            // NotificationHelper.notifyStationChange(_current);
          }

          _isLoaded = true;

          break;
        default:
      }
    });

    _audioPlayer.volumeStream.listen((event) {
      emit(VolumeState(event));
    });
  }

  Future<String> copyDefaultArtImageToStorage() async {
    final Directory tempDir = await getTemporaryDirectory();
    final String tempPath = tempDir.path;
    final String defaultArtImagePath = '$tempPath/logo.png';

    // ignore: unnecessary_nullable_for_final_variable_declarations
    final ByteData? imageData = await rootBundle.load('assets/images/logo.png');
    if (imageData == null) {
      throw Exception('Failed to load default art image');
    }

    final File defaultArtImageFile = File(defaultArtImagePath);
    await defaultArtImageFile.writeAsBytes(imageData.buffer.asUint8List());

    return defaultArtImagePath;
  }

  void play(Station station) async {
    final String defaultArtImagePath = await copyDefaultArtImageToStorage();

    if (station != _current) {
      _audioPlayer.stop();
      _current = station;
      try {
        await _audioPlayer.setAudioSource(
          AudioSource.uri(
            Uri.parse(station.streamUrl!),
            tag: MediaItem(
              // Specify a unique ID for each media item:
              id: '${_nextMediaId++}',
              // Metadata to display in the notification:
              album: "station.title",
              title: station.broadcast!.currentShow == null
                  ? ""
                  : station.broadcast!.currentShow!.show!.name!,
              artist: "Streaming Live",
              artUri: station.broadcast!.currentShow == null
                  ? Uri.file(defaultArtImagePath)
                  : Uri.parse(station.broadcast!.currentShow!.show!.imageUrl!),
            ),
          ),
        );
      } catch (e) {
        emit(ErrorState(false, station));
        rethrow;
      }
    }
    // _audioPlayer.playing ? stop() : _play();
    final processingState = _audioPlayer.playerState.processingState;
    final playing = _audioPlayer.playerState.playing;
    if (playing != true) {
      return _audioPlayer.play();
    } else if (processingState != ProcessingState.completed) {
      return _audioPlayer.stop();
    } else {
      return _audioPlayer.seek(Duration.zero);
    }
  }

  void setVolume(double volume) {
    _audioPlayer.setVolume(volume);
  }

  void stop() {
    _audioPlayer.stop();
  }

  void _play() {
    _audioPlayer.play();
  }

  void play2() {
    _audioPlayer.play();
  }

  setVolume2() {
    return _audioPlayer.setVolume;
  }

  volumeStream() {
    return _audioPlayer.volumeStream;
  }

  volume() {
    return _audioPlayer.volume;
  }

  seak() {
    return _audioPlayer.seek;
  }

  seakw() {
    return _audioPlayer.setSpeed;
  }

  speedStream() {
    return _audioPlayer.speedStream;
  }

  speed() {
    return _audioPlayer.speed;
  }

  void goForward() async {
    await _audioPlayer
        .seek(Duration(seconds: _audioPlayer.position.inSeconds + 10));
  }

  void goBackward() {
    _audioPlayer.seek(Duration(seconds: _audioPlayer.position.inSeconds - 10));
  }

  Stream<PositionData> get positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        _audioPlayer.positionStream,
        _audioPlayer.bufferedPositionStream,
        _audioPlayer.durationStream,
        (position, bufferedPosition, duration) => PositionData(
          position,
          bufferedPosition,
          duration ?? Duration.zero,
        ),
      );

  meta() {
    return _audioPlayer.icyMetadataStream;
  }

  void notificationEvents() async {
    const stream = EventChannel(playerEventChannel);
    stream.receiveBroadcastStream().listen((event) {
      _audioPlayer.playing ? stop() : _play();
    });
  }
}
