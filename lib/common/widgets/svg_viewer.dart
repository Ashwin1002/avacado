import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class SvgViewer {
  const SvgViewer._();
  static fromAsset({
    required String path,
    ColorFilter? colorFilter,
    String? semanticsLabel,
    double? size,
  }) {
    return SizedBox.square(
      dimension: size ?? 18,
      child: SvgPicture.asset(
        path,
        colorFilter: colorFilter,
        semanticsLabel: semanticsLabel,
      ),
    );
  }

  static fromNetwork({
    required String path,
    ColorFilter? colorFilter,
    String? semanticsLabel,
    double? size,
  }) {
    return SizedBox.square(
      dimension: size ?? 18,
      child: SvgPicture.network(
        path,
        colorFilter: colorFilter,
        semanticsLabel: semanticsLabel,
        placeholderBuilder: (BuildContext context) => Container(
          padding: const EdgeInsets.all(30.0),
          child: const CupertinoActivityIndicator(),
        ),
      ),
    );
  }
}
