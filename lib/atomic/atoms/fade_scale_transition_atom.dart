import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class FadeScaleTransitionAtom extends StatefulWidget {
  const FadeScaleTransitionAtom({required this.child, super.key});
  final Widget child;
  @override
  State<FadeScaleTransitionAtom> createState() =>
      _FadeScaleTransitionAtomState();
}

/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class _FadeScaleTransitionAtomState extends State<FadeScaleTransitionAtom>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );

  @override
  void initState() {
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeScaleTransition(
      animation: _animation,
      child: widget.child,
    );
  }
}
