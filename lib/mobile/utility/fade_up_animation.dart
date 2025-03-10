import 'dart:async';

import 'package:flutter/material.dart';

class EFadeUpAnimation extends StatefulWidget {
  const EFadeUpAnimation({
    super.key,
    required this.child,
    this.opacityDuration = 800,
    this.offsetDuration = 800,
  });
  final Widget child;
  final int opacityDuration;
  final int offsetDuration;
  @override
  State<EFadeUpAnimation> createState() => _EFadeUpAnimationState();
}

/// [AnimationController]s can be created with `vsync: this` because of
/// [TickerProviderStateMixin].
class _EFadeUpAnimationState extends State<EFadeUpAnimation>
    with TickerProviderStateMixin {
  late AnimationController _offsetController;
  late AnimationController _opacityController;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _offsetController = AnimationController(
      duration: Duration(milliseconds: widget.offsetDuration),
      vsync: this,
    );
    _opacityController = AnimationController(
      duration: Duration(milliseconds: widget.opacityDuration),
      vsync: this,
    );
    _opacityAnimation = CurvedAnimation(
      parent: _opacityController,
      curve: Curves.easeInOut,
    )..addListener(() {
        setState(() {});
      });
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _offsetController,
      curve: Curves.easeInOut,
    ))
      ..addListener(() {
        setState(() {});
      });
    Timer(const Duration(milliseconds: 50), () {
      if (mounted) {
        _offsetController.forward();
        if (widget.opacityDuration > 0) {
          Timer(
            const Duration(milliseconds: 100),
            // ignore: unnecessary_set_literal
            () => {
              if (mounted) {_opacityController.forward()}
            },
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _offsetController.dispose();
    _opacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.opacityDuration > 0) {
      return SlideTransition(
        position: _offsetAnimation,
        child: FadeTransition(
          opacity: _opacityAnimation,
          child: widget.child,
        ),
      );
    }
    return SlideTransition(
      position: _offsetAnimation,
      child: widget.child,
    );
  }
}
