import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:radio/apps/news_posts/model/post_model.dart';
import 'package:radio/apps/news_posts/view/post_details.dart';
import 'package:radio/helpers/constant/app_styles.dart';
import 'package:radio/helpers/extensions.dart';
import 'package:radio/helpers/utils/datetime_utils.dart';
import 'package:shimmer/shimmer.dart';

var clickCount = 0;

class PostCard extends StatelessWidget {
  const PostCard({Key? key, required this.post}) : super(key: key);
  final Post post;

  get subtitleStyle => null;

  get darkTitleStyle => null;

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      margin: const EdgeInsets.all(0),
      elevation: 0,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  PostDetails(
                pageTitle: post.title!,
                content: post.content!,
                featuredMedia: post.embedded!.wpFeaturedmedia != null
                    ? post.embedded!.wpFeaturedmedia![0].sourceUrl!
                    : '',
              ),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            ),
          );
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Hero(
                tag: post.title!,
                child: post.embedded!.wpFeaturedmedia != null
                    ? CachedNetworkImage(
                        imageUrl: post.embedded!.wpFeaturedmedia![0].sourceUrl!,
                        fit: BoxFit.cover,
                        width: 70,
                        height: 70,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress),
                        ),
                        errorWidget: (context, url, error) => Image.asset(
                          'assets/images/logo.png',
                          fit: BoxFit.cover,
                          width: 70,
                          height: 70,
                        ),
                      )
                    : Container(
                        color: Colors.white,
                        child: Image.asset(
                          'assets/images/logo.png',
                          fit: BoxFit.cover,
                          width: 70,
                          height: 70,
                        ),
                      ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                      child: Text(
                        post.title!.toTitleCase(),
                        style: isDark ? darkTitleStyle : titleStyle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.calendar_month_outlined,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              DateTimeUtils.getFullDate(
                                DateTimeUtils.inputDate(post.date.toString()),
                              ),
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget shimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[700]!,
      highlightColor: Colors.grey[100]!,
      child: Card(
        margin: const EdgeInsets.all(0),
        elevation: 0,
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Container(
                width: 70,
                height: 70,
                color: Colors.white,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                      child: Container(
                        height: 16,
                        width: double.infinity,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                      child: Container(
                        height: 16,
                        width: 120,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
