import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio/apps/news_posts/controller/cubit/post_cubit.dart';
import 'package:radio/apps/news_posts/repository/post_repository.dart';
import 'package:radio/all_screens.dart';
import 'package:radio/helpers/constant/app_styles.dart';

class PostHeaderComponent extends StatefulWidget {
  const PostHeaderComponent({
    Key? key,
  }) : super(key: key);

  @override
  State<PostHeaderComponent> createState() => _PostHeaderComponentState();
}

class _PostHeaderComponentState extends State<PostHeaderComponent> {
  late final PostCubit _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = PostCubit(PostRepository());
    _bloc.fetchPosts();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostCubit, PostState>(
      bloc: _bloc,
      builder: (context, state) {
        if (state is PostLoaded) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Latest News",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: titleStyle,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            PostScreen(),
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
                  child: Text(
                    "View All",
                    style: subtitleStyle,
                  ),
                ),
              ],
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}
