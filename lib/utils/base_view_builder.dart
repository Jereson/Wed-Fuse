import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wedme1/viewModel/base_view_model.dart';

class BaseViewBuilder<T extends BaseViewModel> extends StatefulWidget {
  final T? model;
  final Widget? child;
  final Function(T model)? initState;
  final Widget? Function(T model, Widget? child)? builder;
  final Function(T model)? dispose;
  const BaseViewBuilder({
    Key? key,
    this.child,
    this.dispose,
    this.initState,
    @required this.builder,
    @required this.model,
  }) : super(key: key);

  @override
  State<BaseViewBuilder<T>> createState() => _BaseViewBuilderState<T>();
}

class _BaseViewBuilderState<T extends BaseViewModel>
    extends State<BaseViewBuilder<T>> {
  @override
  void initState() {
    if (widget.initState != null) {
      widget.initState!(widget.model!);
    }
    super.initState();
  }

  @override
  dispose() {
    if (widget.dispose != null) {
      widget.dispose!(widget.model!);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
      value: widget.model!,
      child: Consumer<T>(
        builder: (BuildContext context, T value, Widget? child) {
          return widget.builder!(value, child)!;
        },
        child: widget.child,
      ),
    );
  }
}
