import 'package:flutter/material.dart';
import 'package:lsd/lsd.dart';

import 'lsd_form_data_widget.dart';

class LsdFormFieldWidgetBuilder extends StatefulWidget {
  const LsdFormFieldWidgetBuilder({
    Key? key,
    required this.name,
    required this.builder,
    this.child,
    this.initialValue,
    this.validations = const [],
  }) : super(key: key);
  final String name;
  final Widget Function(
    BuildContext context,
    TextEditingController controller,
    String? error,
    Widget? child,
  ) builder;

  final Widget? child;
  final String? initialValue;
  final List<LsdAction> validations;

  @override
  State<LsdFormFieldWidgetBuilder> createState() =>
      _LsdFormFieldWidgetBuilderState();
}

class _LsdFormFieldWidgetBuilderState extends State<LsdFormFieldWidgetBuilder> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    Future.microtask(() {
      final lsdFormData = LsdFormDataWidget.of(context);
      lsdFormData.register(
        widget.name,
        widget.initialValue ?? "",
        widget.validations,
      );

      _controller.text = lsdFormData.values[widget.name]!;
    });

    _controller.addListener(_onChanged);

    super.initState();
  }

  _onChanged() {
    LsdFormDataWidget.of(context).setValue(widget.name, _controller.text);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Map<String, String>>(
      valueListenable: LsdFormDataWidget.of(context).errors,
      builder: (context, errors, child) {
        return widget.builder(context, _controller, errors[widget.name], child);
      },
      child: widget.child,
    );
  }
}
