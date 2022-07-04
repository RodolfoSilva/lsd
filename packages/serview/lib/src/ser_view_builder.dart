import 'package:flutter/widgets.dart';

import 'ser_view.dart';
import 'ser_view_error.dart';

class SerViewBuilder extends StatelessWidget {
  const SerViewBuilder(
      {Key? key,
      required Map<String, dynamic> element,
      required SerView serView})
      : _element = element,
        _serView = serView,
        super(key: key);

  final Map<String, dynamic> _element;
  final SerView _serView;

  @override
  Widget build(BuildContext context) {
    try {
      return _serView.parse(_element).build(context);
    } on SerViewError catch (e) {
      debugPrint(e.toString());
      return _serView.renderError(context, e);
    }
  }
}
