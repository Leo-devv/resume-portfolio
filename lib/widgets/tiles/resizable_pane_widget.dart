// resizable_pane_widget.dart
import 'package:flutter/material.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn;

class ResizablePaneWidget extends StatelessWidget {
  final shadcn.ResizablePaneController _controller =
      shadcn.ResizablePaneController(200);

  @override
  Widget build(BuildContext context) {
    return shadcn.OutlinedContainer(
      clipBehavior: Clip.antiAlias,
      child: shadcn.ResizablePanel(
        direction: Axis.horizontal,
        children: [
          shadcn.ResizablePane.controlled(
            minSize: 100,
            collapsedSize: 40,
            controller: _controller,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                if (_controller.collapsed) {
                  return Container(
                    alignment: Alignment.center,
                    height: 400,
                    child: const RotatedBox(
                      quarterTurns: -1,
                      child: Text('Before'),
                    ),
                  );
                }
                return Container(
                  alignment: Alignment.center,
                  height: 400,
                  child: Image.asset(
                      'poster.png'), // Replace with your before image
                );
              },
            ),
          ),
          shadcn.ResizablePane(
            initialSize: 300,
            child: Container(
              alignment: Alignment.center,
              height: 400,
              child: Image.asset("poster.png"), // Replace with your after image
            ),
          ),
        ],
      ),
    );
  }
}
