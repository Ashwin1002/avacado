import 'package:avacado_task/common/service/network/exception_handler.dart';
import 'package:avacado_task/src/home/model/post_model.dart';
import 'package:avacado_task/src/home/repository/home_repository.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';
part 'home_event.dart';
part 'home_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository repository;

  HomeBloc({required this.repository}) : super(const HomeState()) {
    on<HomeEvent>(
      (event, emit) async {
        if (event is FetchPostListEvent) {
          print('refresh');
          await _fetchPostList(event, emit);
        }
      },
      transformer: throttleDroppable(throttleDuration),
    );
  }

  Future<void> _fetchPostList(FetchPostListEvent event, Emitter<HomeState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == HomeStatus.loading) {
        final postList = await repository.getPosts(postLimit: event.postLimit, startIndex: event.startIndex);
        return emit(state.copyWith(
          status: HomeStatus.success,
          posts: postList,
          hasReachedMax: false,
        ));
      }
      final postList =
          await repository.getPosts(startIndex: state.posts.length);
      emit(
        postList.isEmpty
            ? state.copyWith(hasReachedMax: true, message: 'No Data Found')
            : state.copyWith(
                status: HomeStatus.success,
                posts: List.of(state.posts)..addAll(postList),
                hasReachedMax: false,
              ),
      );
    } catch (e) {
      emit(state.copyWith(
        status: HomeStatus.error,
        message: ExceptionHandler().parseError(e),
      ));
    }
  }
}
