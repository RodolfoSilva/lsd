import 'package:flutter/widgets.dart';

import '../error/error.dart';
import '../lsd.dart';
import '../widget/widget.dart';

class LsdSafeWidgetBuilder extends StatefulWidget {
  const LsdSafeWidgetBuilder({
    Key? key,
    required Map<String, dynamic> element,
    required Lsd lsd,
  })  : _element = element,
        _lsd = lsd,
        super(key: key);

  final Map<String, dynamic> _element;
  final Lsd _lsd;

  @override
  State<LsdSafeWidgetBuilder> createState() => _LsdSafeWidgetBuilderState();
}

class _LsdSafeWidgetBuilderState extends State<LsdSafeWidgetBuilder> {
  late _ParseState _parseState;

  @override
  void initState() {
    super.initState();
    try {
      _parseState =
          _ParseStateSuccess(widget._lsd.parseWidget(widget._element));
    } on LsdError catch (e) {
      _parseState = _ParseStateError(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_parseState is _ParseStateSuccess) {
      return (_parseState as _ParseStateSuccess).widget.toWidget(context);
    }

    if (_parseState is _ParseStateError) {
      return widget._lsd.renderError(
        context,
        (_parseState as _ParseStateError).error,
      );
    }

    return widget._lsd.renderError(
      context,
      LsdBuildError("Unknown parse state"),
    );
  }
}

abstract class _ParseState {}

class _ParseStateSuccess extends _ParseState {
  _ParseStateSuccess(this.widget);
  final LsdWidget widget;
}

class _ParseStateError extends _ParseState {
  _ParseStateError(this.error);
  final LsdError error;
}
