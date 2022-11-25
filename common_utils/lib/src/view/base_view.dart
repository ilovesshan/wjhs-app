import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseView<T extends ChangeNotifier> extends StatefulWidget {
  late Widget Function(BuildContext context, T value, Widget? child) builder;
  late T mode;
  late Widget child;
  late Function(T) onReady;
  late bool autoDispose = true;

  BaseView(
      {required this.builder,
      required this.mode,
      required this.child,
      required this.onReady,
      bool? autoDispose});

  @override
  State<BaseView<T>> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends ChangeNotifier> extends State<BaseView<T>> {
  @override
  void initState() {
    super.initState();
      widget.onReady.call(widget.mode);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
      value: widget.mode,
      child: Consumer<T>(builder: widget.builder, child: widget.child),
    );
  }

  @override
  void dispose() {
    if (widget.autoDispose) {
      widget.mode.dispose();
    }
    super.dispose();
  }
}
