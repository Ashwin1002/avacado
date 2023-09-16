import 'package:flutter/material.dart';

class CustomTransitionWidget extends StatelessWidget {
  const CustomTransitionWidget({
    super.key,
    required AnimationController animation,
    required Animation<Offset> offsetAnimation,
    required Animation<double> opacityAnimation,
    required this.child,
  })  : _animation = animation,
        _offsetAnimation = offsetAnimation,
        _opacityAnimation = opacityAnimation;

  final AnimationController _animation;
  final Animation<Offset> _offsetAnimation;
  final Animation<double> _opacityAnimation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return SlideTransition(
          position: _offsetAnimation,
          child: FadeTransition(
            opacity: _opacityAnimation,
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
