// ignore_for_file: prefer__constructors, prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:avacado_task/src/home/bloc/home_bloc.dart';

void main() {
  group('HomeState Test', () {
    test('Home State value comparison', () {
      expect(HomeState(), HomeState());
      expect(
        HomeState().toString(),
        HomeState().toString(),
      );
    });
  });
}
