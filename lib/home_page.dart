import 'package:flutter/material.dart';
import 'package:track_shadow_on_hover/interactive_shadow_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Offset _mousePosition = Offset.zero;
  bool _isMouseInside = false;
  void _updateMousePosition(PointerEvent details) {
    setState(() {
      _mousePosition = details.position;
      _isMouseInside = true;
    });
  }

  void _resetMousePosition() {
    setState(() {
      _mousePosition = Offset.zero;
      _isMouseInside = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: double.maxFinite),
          MouseRegion(
            onHover: _updateMousePosition,
            onExit: (event) => _resetMousePosition(),
            child: InteractiveShadowWidget(
              isMouseInside: _isMouseInside,
              globalMousePosition: _mousePosition,
              child: Container(
                height: 300,
                width: 300,
                color: Theme.of(context).colorScheme.surfaceBright,
                child: Center(
                  child: Text(
                    'Hover me!',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
