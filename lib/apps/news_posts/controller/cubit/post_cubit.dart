import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:radio/apps/news_posts/model/post_model.dart';
import 'package:radio/apps/news_posts/repository/post_repository.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit(this._repository) : super(PostInitial());

  final PostRepository _repository;

  Future<void> fetchPosts() async {
    try {
      emit(PostLoading());
      final List<Post> posts = await _repository.fetchPosts();
      if (isClosed) return;
      if (posts.isEmpty) {
        emit(EmptyState());
      } else {
        emit(PostLoaded(posts));
      }
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }
}
