import 'package:flutter/material.dart';
import 'package:lsd/lsd.dart';

import 'lsd_form_data_state.dart';
import 'lsd_form_data_widget.dart';

class LsdFormWidget extends LsdWidget {
  late LsdWidget child;

  LsdFormWidget(super.lsd);

  @override
  LsdWidget fromJson(Map<String, dynamic> props) {
    child = lsd.parseWidget(props["child"]);
    return super.fromJson(props);
  }

  @override
  Widget build(BuildContext context) {
    return _FormWidget(
      lsd: lsd,
      child: child,
    );
  }
}

class _FormWidget extends StatefulWidget {
  const _FormWidget({
    Key? key,
    required this.lsd,
    required this.child,
  }) : super(key: key);

  final Lsd lsd;
  final LsdWidget child;

  @override
  State<_FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<_FormWidget> {
  late LsdFormDataState _formDataState;
  @override
  void initState() {
    super.initState();

    _formDataState = LsdFormDataState();
  }

  @override
  Widget build(BuildContext context) {
    return LsdFormDataWidget(
      lsd: widget.lsd,
      formState: _formDataState,
      child: Builder(
        builder: (context) => widget.child.build(context),
      ),
    );
  }
}
