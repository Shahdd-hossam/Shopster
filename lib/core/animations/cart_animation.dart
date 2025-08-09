import 'package:flutter/material.dart';

class CardAnimations {
  // Zoom animation for cards when tapped
  static Widget zoomOnTap({
    required Widget child,
    required VoidCallback onTap,
    double scaleFactor = 0.95,
    Duration duration = const Duration(milliseconds: 150),
  }) {
    return _ZoomTapWidget(
      onTap: onTap,
      scaleFactor: scaleFactor,
      duration: duration,
      child: child,
    );
  }

  // Hover animation for cards
  static Widget hoverAnimation({
    required Widget child,
    double hoverScale = 1.05,
    Duration duration = const Duration(milliseconds: 200),
  }) {
    return _HoverWidget(
      hoverScale: hoverScale,
      duration: duration,
      child: child,
    );
  }

  // Slide up animation for cards
  static Widget slideUpAnimation({
    required Widget child,
    Duration duration = const Duration(milliseconds: 300),
    Duration delay = Duration.zero,
  }) {
    return _SlideUpWidget(
      duration: duration,
      delay: delay,
      child: child,
    );
  }

  // Staggered animation for multiple cards
  static List<Widget> staggeredCards({
    required List<Widget> children,
    Duration interval = const Duration(milliseconds: 100),
  }) {
    return children.asMap().entries.map((entry) {
      int index = entry.key;
      Widget child = entry.value;
      
      return _DelayedAnimation(
        delay: Duration(milliseconds: index * interval.inMilliseconds),
        child: child,
      );
    }).toList();
  }
}

class _ZoomTapWidget extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  final double scaleFactor;
  final Duration duration;

  const _ZoomTapWidget({
    required this.child,
    required this.onTap,
    required this.scaleFactor,
    required this.duration,
  });

  @override
  State<_ZoomTapWidget> createState() => _ZoomTapWidgetState();
}

class _ZoomTapWidgetState extends State<_ZoomTapWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: widget.scaleFactor,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onTap();
      },
      onTapCancel: () => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: widget.child,
          );
        },
      ),
    );
  }
}

class _HoverWidget extends StatefulWidget {
  final Widget child;
  final double hoverScale;
  final Duration duration;

  const _HoverWidget({
    required this.child,
    required this.hoverScale,
    required this.duration,
  });

  @override
  State<_HoverWidget> createState() => _HoverWidgetState();
}

class _HoverWidgetState extends State<_HoverWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: widget.hoverScale,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _controller.forward(),
      onExit: (_) => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: widget.child,
          );
        },
      ),
    );
  }
}

class _SlideUpWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;

  const _SlideUpWidget({
    required this.child,
    required this.duration,
    required this.delay,
  });

  @override
  State<_SlideUpWidget> createState() => _SlideUpWidgetState();
}

class _SlideUpWidgetState extends State<_SlideUpWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return SlideTransition(
          position: _slideAnimation,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: widget.child,
          ),
        );
      },
    );
  }
}

class _DelayedAnimation extends StatefulWidget {
  final Widget child;
  final Duration delay;

  const _DelayedAnimation({
    required this.child,
    required this.delay,
  });

  @override
  State<_DelayedAnimation> createState() => _DelayedAnimationState();
}

class _DelayedAnimationState extends State<_DelayedAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - _animation.value)),
          child: Opacity(
            opacity: _animation.value,
            child: widget.child,
          ),
        );
      },
    );
  }
}