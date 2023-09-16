// ignore_for_file: prefer_const_constructors
import 'package:avacado_task/src/home/bloc/home_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HomeEvent Test', () {
    group('FetchPostListEvent test ', () {
      test('Home Event value comparison', () {
        expect(FetchPostListEvent(), FetchPostListEvent());
      });
    });
  });
}
