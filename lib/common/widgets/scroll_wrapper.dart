import 'package:flutter/material.dart';

class ScrollWrapperWidegt extends StatelessWidget {
  const ScrollWrapperWidegt({
    super.key,
    required this.child,
    required this.scrollController,
  });

  final Widget child;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: scrollController,
      builder: (context, child) {
        final renderObject = context.findRenderObject() as RenderBox;
        final offsetY = renderObject.localToGlobal(Offset.zero).dy;
        if (offsetY <= 0) {
          return child!;
        }
        final deviceHeight = MediaQuery.sizeOf(context).height;
        final heightVisible = deviceHeight - offsetY;
        final widgetHeight = renderObject.size.height;

        final howMuchShown = (heightVisible / widgetHeight).clamp(0.0, 1.0);
        final scale = .8 + howMuchShown * .2;
        final opacity = 0.25 + howMuchShown * .75;
        return Transform.scale(
          scale: scale,
          alignment: Alignment.center,
          child: Opacity(
            opacity: opacity,
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
