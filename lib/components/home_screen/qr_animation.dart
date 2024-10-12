import 'package:flutter/material.dart';

class QrAnimation extends StatefulWidget {
  const QrAnimation({super.key});

  @override
  State<QrAnimation> createState() => _QrAnimationState();
}

class _QrAnimationState extends State<QrAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 800))
    ..repeat(reverse: true);
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  late final Animation<Offset> _animation = Tween(
          begin: Offset(0, -MediaQuery.sizeOf(context).height * 0.05),
          end: Offset(0, MediaQuery.sizeOf(context).height * 0.05))
      .animate(controller);

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.6,
        height: 3,
        color: Colors.red,
      ),
    );
  }
}
