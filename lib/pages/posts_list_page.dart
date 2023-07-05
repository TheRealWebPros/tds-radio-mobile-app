import 'package:flutter/material.dart';
import 'package:radio/apps/news_posts/view/post_component.dart';
import 'package:radio/helpers/constant/app_styles.dart';

class PostsPageList extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const PostsPageList({
    Key? key,
    required this.scaffoldKey,
  }) : super(key: key);

  @override
  State<PostsPageList> createState() => _PostsPageListState();
}

class _PostsPageListState extends State<PostsPageList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: appBarbg,
      child: SafeArea(
        top: false,
        child: Scaffold(
          body: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar.large(
                  automaticallyImplyLeading: true,
                  centerTitle: false,
                  backgroundColor: appBarbg,
                  elevation: 0,
                  title: const Text("Latest News Headlines"),
                  leading: Builder(
                    builder: (context) => IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ),
              ];
            },
            body: const CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: PostComponent(
                      count: -4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
