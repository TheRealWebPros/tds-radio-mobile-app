import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
// ignore: library_prefixes
import 'package:radio/widgets/back_button.dart' as BackButtonWidget;
import 'package:radio/widgets/invisible_expanded_header.dart';
import 'package:radio/helpers/constant/app_styles.dart';
import 'package:radio/helpers/extensions.dart';
import 'package:radio/main_layout.dart';

import '../../../helpers/url_launcher.dart';

class PostDetails extends StatefulWidget {
  final String pageTitle;
  final String content;
  final String featuredMedia;

  const PostDetails({
    Key? key,
    required this.pageTitle,
    required this.content,
    required this.featuredMedia,
  }) : super(key: key);

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return MainLayout(
      scaffoldKey: _scaffoldKey,
      child: Container(
        color: appBarbg,
        child: SafeArea(
          top: false,
          child: Scaffold(
            body: NestedScrollView(
              floatHeaderSlivers: true,
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    leading: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: BackButtonWidget.BackButttonWidget(
                        color: Colors.white,
                        bgColor: Colors.black,
                      ),
                    ),
                    pinned: true,
                    snap: false,
                    floating: false,
                    expandedHeight: screenSize.width >= 480 ? 600 : 300.0,
                    flexibleSpace: FlexibleSpaceBar(
                      title: InvisibleExpandedHeader(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 0.0),
                          child: Text(
                            widget.pageTitle.toTitleCase(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                      ),
                      background: Hero(
                        tag: widget.pageTitle,
                        child: CachedNetworkImage(
                          imageUrl: widget.featuredMedia,
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
                        ),
                      ),
                    ),
                  ),
                ];
              },
              body: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(widget.pageTitle),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Html(
                        data: widget.content,
                        onLinkTap: (url, attributes, element) {
                          launchURL(
                            Uri.parse(url!),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
