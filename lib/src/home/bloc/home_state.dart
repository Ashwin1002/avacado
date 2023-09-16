part of 'home_bloc.dart';

enum HomeStatus { loading, success, error }

final class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.loading,
    this.posts = const <PostModel>[],
    this.hasReachedMax = false,
    this.message = '',
  });

  final HomeStatus status;
  final List<PostModel> posts;
  final bool hasReachedMax;
  final String message;

  HomeState copyWith({
    HomeStatus? status,
    List<PostModel>? posts,
    bool? hasReachedMax,
    String? message,
  }) {
    return HomeState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      message: message ?? this.message,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, hasReachedMax: $hasReachedMax, posts: ${posts.length}, message: $message }''';
  }

  @override
  List<Object> get props => [status, posts, hasReachedMax];
}
