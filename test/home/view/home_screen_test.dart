import 'package:avacado_task/src/home/bloc/home_bloc.dart';
import 'package:avacado_task/src/home/model/post_model.dart';
import 'package:avacado_task/src/home/view/view.dart';
import 'package:avacado_task/src/home/widgets/grid_list_item.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeBloc extends MockBloc<HomeEvent, HomeState> implements HomeBloc {}

extension on WidgetTester {
  Future<void> pumpPostsList(HomeBloc homeBloc) {
    return pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: homeBloc,
          child: const HomeScreen(),
        ),
      ),
    );
  }
}

void main() {
  final mockPostList = List.generate(
    5,
    (i) => PostModel(id: i, title: 'post title', body: 'post body', userId: 1),
  );

  late HomeBloc homeBloc;

  setUp(() {
    homeBloc = MockHomeBloc();
  });

  group('Fetch Post in Home Bloc', () {
    testWidgets(
        'renders CircularProgressIndicator '
        'when home status is loading', (tester) async {
      when(() => homeBloc.state).thenReturn(const HomeState());
      await tester.pumpPostsList(homeBloc);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets(
        'renders no data found text '
        'when post status is success but with 0 posts', (tester) async {
      when(() => homeBloc.state).thenReturn(
        const HomeState(status: HomeStatus.success, hasReachedMax: true),
      );
      await tester.pumpPostsList(homeBloc);
      expect(find.text('No Data Found'), findsOneWidget);
    });

    testWidgets(
        'renders 2 posts item and a bottom loader when post max is not reached yet',
        (tester) async {
      when(() => homeBloc.state).thenReturn(
        HomeState(
          status: HomeStatus.success,
          posts: mockPostList,
        ),
      );
      await tester.pumpPostsList(homeBloc);
      expect(find.byType(GridListItemWidget), findsNWidgets(2));
    });

    testWidgets(
        'Hide the bottom cupertino activity indicator when max no. of post is reached',
        (tester) async {
      when(() => homeBloc.state).thenReturn(
        HomeState(
          status: HomeStatus.success,
          posts: mockPostList,
          hasReachedMax: true,
        ),
      );
      await tester.pumpPostsList(homeBloc);
      expect(find.byType(CupertinoActivityIndicator), findsNothing);
    });

    testWidgets('Fetch more post when scrolled to the bottom of the page',
        (tester) async {
      when(() => homeBloc.state).thenReturn(
        HomeState(
          status: HomeStatus.success,
          posts: List.generate(
            1,
            (i) => PostModel(
              id: i,
              title: 'demo title',
              body: 'demo body',
              userId: i,
            ),
          ),
        ),
      );
      await tester.pumpPostsList(homeBloc);
      await tester.drag(find.byType(GridListItemWidget), const Offset(0, -500));
      verify(() => homeBloc.add(FetchPostListEvent())).called(1);
    });
  });
}
