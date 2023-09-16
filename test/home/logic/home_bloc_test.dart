import 'package:avacado_task/src/home/bloc/bloc.dart';
// import 'package:avacado_task/src/home/model/post_model.dart';
import 'package:avacado_task/src/home/repository/home_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';

// _getPosts() {
//   return [const PostModel(userId: 1, id: 1, title: 'title', body: 'body')];
// }

void main() {
  group('PostBloc', () {
    // const mockPosts = [
    //   PostModel(id: 1, title: 'title', body: 'body', userId: 1),
    // ];
    test('loading state is HomeState()', () {
      expect(HomeBloc(repository: HomeRepository()).state, const HomeState());
    });

    group('Post Fetched event is pressed', () {
      blocTest<HomeBloc, HomeState>(
        'emits nothing when max post is fetched from api',
        build: () => HomeBloc(repository: HomeRepository()),
        seed: () => const HomeState(hasReachedMax: true),
        act: (bloc) => bloc.add(FetchPostListEvent()),
        expect: () => <HomeState>[],
      );
    });
  });
}
