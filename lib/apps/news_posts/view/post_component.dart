import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio/apps/news_posts/controller/cubit/post_cubit.dart';
import 'package:radio/apps/news_posts/repository/post_repository.dart';
import 'package:radio/apps/news_posts/view/post_card.dart';

class PostComponent extends StatefulWidget {
  final int count;

  const PostComponent({Key? key, required this.count}) : super(key: key);

  @override
  State<PostComponent> createState() => _PostComponentState();
}

class _PostComponentState extends State<PostComponent> {
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
        if (state is PostLoading) {
          return ListView.separated(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 5,
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(key: Key('separator'));
            },
            itemBuilder: (BuildContext context, int index) {
              return PostCard.shimmer();
            },
          );
        }
        if (state is PostLoaded) {
          final posts = state.posts;
          int? childCount;

          if (widget.count < posts.length) {
            childCount = widget.count;
          }
          if (widget.count.isNegative || widget.count > posts.length) {
            childCount = posts.length;
          }

          return ListView.separated(
            padding: const EdgeInsets.all(0),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: childCount!,
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(key: Key('separator'));
            },
            itemBuilder: (BuildContext context, int index) {
              return PostCard(post: posts[index]);
            },
          );
        }
        if (state is PostError) {
          return SizedBox(
            child: Text(state.errorMessage),
          );
        }

        if (state is EmptyState) {
          return const Padding(
            padding: EdgeInsets.all(8.0),
            child: SizedBox(
              child: Text("There is no news at the moment. Please try again."),
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}
