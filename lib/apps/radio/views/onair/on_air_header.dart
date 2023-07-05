import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:radio/apps/radio/model/station.dart';
import 'package:radio/helpers/constant/app_styles.dart';
import 'package:radio/helpers/extensions.dart';
import 'package:radio/widgets/contacts.dart';
import 'package:shimmer/shimmer.dart';

class OnAirHeader extends StatelessWidget {
  final CurrentShow currentShow;

  const OnAirHeader({Key? key, required this.currentShow}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: currentShow.show!.imageUrl!.isNotEmpty
              ? Container(
                  color: Colors.grey.shade50,
                  child: CachedNetworkImage(
                    imageUrl: currentShow.show!.imageUrl!,
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                      child: CircularProgressIndicator(
                          value: downloadProgress.progress),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                )
              : Container(
                  color: Colors.pink.shade100,
                  child: Image.asset(
                    "assets/images/logo.png",
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(left: 25, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.red.shade500,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  child: const Text(
                    "Now On-air",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  currentShow.show!.name!.toTitleCase(),
                  style: titleStyle,
                ),
                Text(
                  "${currentShow.start} - ${currentShow.end}",
                  style: subtitleStyle,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Contacts()
              ],
            ),
          ),
        )
      ],
    );
  }

  static Widget shimmer() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[700]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 150,
              height: 150,
              color: Colors.grey.shade200,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 25, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[700]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: double.infinity,
                    height: 16,
                    color: Colors.grey.shade200,
                  ),
                ),
                const SizedBox(height: 8),
                Shimmer.fromColors(
                  baseColor: Colors.grey[700]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: double.infinity,
                    height: 16,
                    color: Colors.grey.shade200,
                  ),
                ),
                const SizedBox(height: 4),
                Shimmer.fromColors(
                  baseColor: Colors.grey[700]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: 100,
                    height: 16,
                    color: Colors.grey.shade200,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
