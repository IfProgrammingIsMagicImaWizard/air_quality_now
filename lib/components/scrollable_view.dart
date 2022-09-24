import 'package:flutter/material.dart';

class ScrollableView extends StatelessWidget {
  final Widget child;
  final AppBar? appbar;
  const ScrollableView({required this.child, this.appbar, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbar,
        body: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const ScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: child,
              ),
            ),
          ),
        ));
  }
}
