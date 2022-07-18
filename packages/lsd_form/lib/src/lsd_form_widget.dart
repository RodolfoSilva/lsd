import 'package:flutter/material.dart';
import 'package:lsd/lsd.dart';

import 'lsd_form_data_state.dart';
import 'lsd_form_provider.dart';

class LsdFormWidget extends LsdWidget {
  late LsdWidget child;

  LsdFormWidget(super.lsd);
  late Map<String, String?> values;

  @override
  LsdWidget fromJson(Map<String, dynamic> props) {
    child = lsd.parseWidget(props["child"]);
    values = Map<String, String?>.from(props["values"] ?? {});
    return super.fromJson(props);
  }

  @override
  Widget build(BuildContext context) {
    return _FormWidget(
      lsd: lsd,
      values: values,
      child: child,
    );
  }
}

class _FormWidget extends StatefulWidget {
  const _FormWidget({
    Key? key,
    required this.lsd,
    required this.values,
    required this.child,
  }) : super(key: key);

  final Lsd lsd;
  final LsdWidget child;
  final Map<String, String?> values;

  @override
  State<_FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<_FormWidget> {
  late LsdFormDataState _formDataState;
  @override
  void initState() {
    super.initState();

    _formDataState = LsdFormDataState(values: widget.values);
  }

  @override
  Widget build(BuildContext context) {
    return LsdFormProvider(
      lsd: widget.lsd,
      formState: _formDataState,
      child: Builder(
        builder: (context) => widget.child.toWidth(context),
      ),
    );
  }
}
