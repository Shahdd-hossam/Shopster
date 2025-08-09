import 'package:flutter/material.dart';

class AnimationUtils {
  // Fade transition animation
  static Widget fadeTransition({
    required Animation<double> animation,
    required Widget child,
  }) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  // Slide transition animation (from right to left)
  static Widget slideTransition({
    required Animation<double> animation,
    required Widget child,
    Offset begin = const Offset(1.0, 0.0),
    Offset end = Offset.zero,
  }) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: begin,
        end: end,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOut,
      )),
      child: child,
    );
  }

  // Scale transition animation (zoom in/out)
  static Widget scaleTransition({
    required Animation<double> animation,
    required Widget child,
    double begin = 0.0,
    double end = 1.0,
  }) {
    return ScaleTransition(
      scale: Tween<double>(
        begin: begin,
        end: end,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: Curves.elasticOut,
      )),
      child: child,
    );
  }

  // Combined scale and fade animation
  static Widget scaleFadeTransition({
    required Animation<double> animation,
    required Widget child,
  }) {
    return ScaleTransition(
      scale: Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: Curves.elasticOut,
      )),
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }

  // Rotation transition animation
  static Widget rotationTransition({
    required Animation<double> animation,
    required Widget child,
    double begin = 0.0,
    double end = 1.0,
  }) {
    return RotationTransition(
      turns: Tween<double>(
        begin: begin,
        end: end,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: Curves.elasticOut,
      )),
      child: child,
    );
  }

  // Page route with custom transition
  static PageRouteBuilder<T> createRoute<T>({
    required Widget page,
    TransitionType transitionType = TransitionType.slideFromRight,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        switch (transitionType) {
          case TransitionType.fade:
            return fadeTransition(animation: animation, child: child);
          case TransitionType.slideFromRight:
            return slideTransition(animation: animation, child: child);
          case TransitionType.slideFromLeft:
            return slideTransition(
              animation: animation,
              child: child,
              begin: const Offset(-1.0, 0.0),
            );
          case TransitionType.slideFromTop:
            return slideTransition(
              animation: animation,
              child: child,
              begin: const Offset(0.0, -1.0),
            );
          case TransitionType.slideFromBottom:
            return slideTransition(
              animation: animation,
              child: child,
              begin: const Offset(0.0, 1.0),
            );
          case TransitionType.scale:
            return scaleTransition(animation: animation, child: child);
          case TransitionType.scaleFade:
            return scaleFadeTransition(animation: animation, child: child);
        }
      },
    );
  }
}

enum TransitionType {
  fade,
  slideFromRight,
  slideFromLeft,
  slideFromTop,
  slideFromBottom,
  scale,
  scaleFade,
}
