import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:radio/apps/radio/bloc/radio_bloc.dart';
import 'package:radio/apps/radio/bloc/radio_state.dart';
import 'package:radio/apps/radio/views/player/live_fab.dart';
import 'package:radio/config.dart';
import 'package:radio/helpers/constant/app_styles.dart';

class PlayerComponent extends StatefulWidget {
  const PlayerComponent({Key? key}) : super(key: key);

  @override
  State<PlayerComponent> createState() => _PlayerComponentState();
}

class _PlayerComponentState extends State<PlayerComponent> {
  late RadioBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<RadioBloc>();
  }

  @override
  Widget build(BuildContext context) {
    var statioLogo = Config.radioLogo;

    return SizedBox(
      height: 65,
      child: BlocBuilder<RadioBloc, RadioState>(
        bloc: _bloc,
        buildWhen: (prev, curr) => curr is! VolumeState,
        builder: (_, state) {
          if (state is PlayingState) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed("/player");
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: Container(
                  height: 60,
                  padding: const EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.8),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                  ),
                  child: StreamBuilder<IcyMetadata?>(
                    stream: _bloc.meta(),
                    builder: (context, snapshot) {
                      final metadata = snapshot.data;
                      final title = metadata?.info?.title ?? 'Live Streaming';
                      final artwork = metadata?.info?.url ?? statioLogo;

                      return BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 20,
                          sigmaY: 50,
                          tileMode: TileMode.mirror,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _cover(artwork),
                            Flexible(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      (title == "" || title.contains("Unknown")
                                          ? "Now Playing"
                                          : "Now Playing"),
                                      maxLines: 2,
                                      style: titleStyle,
                                    ),
                                    Text(
                                      (title == "" || title.contains("Unknown")
                                          ? "Live...${state.station.broadcast!.currentShow != null ? state.station.broadcast!.currentShow!.show!.name : Config.appName}"
                                          : title),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: subtitleStyle,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            _playButton(state),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          }

          if (state is LoadingState) {
            return Container(
              padding: const EdgeInsets.all(5),
              height: 60,
              width: MediaQuery.of(context).size.width,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 20,
                  sigmaY: 50,
                  tileMode: TileMode.mirror,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _cover(statioLogo),
                    const Flexible(
                      child: Center(
                          child: Text(
                        "Loading...",
                        overflow: TextOverflow.ellipsis,
                      )),
                    ),
                    FloatingActionButton(
                      backgroundColor: Colors.black,
                      elevation: 0,
                      onPressed: () {},
                      child: const CircularProgressIndicator(
                        backgroundColor: kGrey8E,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          if (state is ErrorState) {
            return Container(
              padding: const EdgeInsets.all(5),
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context).colorScheme.background.withOpacity(1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FloatingActionButton(
                      backgroundColor: Colors.red,
                      elevation: 0,
                      onPressed: () {
                        _bloc.play(state.station);
                      },
                      child: const Icon(Icons.reset_tv)),
                  const Flexible(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "Try Again",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return const Padding(
            padding: EdgeInsets.all(4.0),
            child: LiveFab(),
          );
        },
      ),
    );
  }

  Widget _playButton(PlayingState playingState) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return FloatingActionButton(
      backgroundColor: isDark
          ? Colors.white.withOpacity(0.2)
          : Colors.yellow.shade900.withOpacity(0.2),
      onPressed: () {
        _bloc.play(playingState.station);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(42),
        ),
        child: Icon(
          playingState.playing ? Icons.pause_rounded : Icons.play_arrow_rounded,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _cover(String coverUrl) {
    return Padding(
      padding: const EdgeInsets.only(left: 0.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: coverUrl.isEmpty
            ? Image.asset(
                "assets/images/icon.png",
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              )
            : Hero(
                tag: coverUrl,
                child: CachedNetworkImage(
                  imageUrl: coverUrl,
                  fit: BoxFit.fill,
                  width: 55,
                  height: 55,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                    child: CircularProgressIndicator(
                      value: downloadProgress.progress,
                    ),
                  ),
                  errorWidget: (context, url, error) =>
                      Image.asset('assets/images/logo.png'),
                ),
              ),
      ),
    );
  }
}
