// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:avacado_task/src/home/view/home_screen.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:avacado_task/main.dart';

void main() {
  group('App', () {
    testWidgets('render home page when app is first launched', (tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();
      expect(find.byType(HomeScreen), findsOneWidget);
    });
  });
}
