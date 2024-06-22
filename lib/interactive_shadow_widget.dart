import 'package:flutter/material.dart';

class InteractiveShadowWidget extends StatelessWidget {
  final Widget child;
  final Offset globalMousePosition;
  final bool isMouseInside;
  final double hoverRegionSize;
  final Color shadowColor;
  final double blurRadius;
  final double spreadRadius;
  final double shadowOpacity;
  final Duration animationDuration;
  final double shadowOffsetScale;

  const InteractiveShadowWidget({
    super.key,
    required this.child,
    required this.globalMousePosition,
    required this.isMouseInside,
    this.hoverRegionSize = 200,
    this.shadowColor = Colors.black,
    this.blurRadius = 20,
    this.spreadRadius = 30,
    this.shadowOpacity = 0.4,
    this.animationDuration = const Duration(milliseconds: 10),
    this.shadowOffsetScale = 10.0,
  });

  @override
  Widget build(BuildContext context) {
    Offset localPosition = Offset.zero;
    Size childSize = Size.zero;

    if (isMouseInside) {
      RenderBox box = context.findRenderObject() as RenderBox;
      localPosition = box.globalToLocal(globalMousePosition);
      childSize = box.size;
    }

    Offset centerOffset = Offset(
          (localPosition.dx - (childSize.width / 2)),
          (localPosition.dy - (childSize.height / 2)),
        ) /
        shadowOffsetScale;

    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.all(hoverRegionSize),
          child: AnimatedContainer(
            duration: animationDuration,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: shadowColor.withOpacity(shadowOpacity),
                  offset: centerOffset,
                  blurRadius: blurRadius,
                  spreadRadius: spreadRadius,
                ),
              ],
            ),
            child: child,
          ),
        ),
      ],
    );
  }
}
