import 'package:avacado_task/src/home/model/post_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Post Model Test', () {
    test('Post Model from Json', () {
      expect(
        const PostModel(
          id: 1,
          title: 'title 1',
          body: 'description 1',
          userId: 2,
        ),
        const PostModel(
          id: 1,
          title: 'title 1',
          body: 'description 1',
          userId: 2,
        ),
      );
    });
  });
}
