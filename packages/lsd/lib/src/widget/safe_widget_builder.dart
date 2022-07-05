import 'package:flutter/widgets.dart';

import '../error/error.dart';
import '../lsd.dart';

class LsdSafeWidgetBuilder extends StatelessWidget {
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
  Widget build(BuildContext context) {
    try {
      return _lsd.parseWidget(_element).build(context);
    } on LsdError catch (e) {
      debugPrint(e.toString());
      return _lsd.renderError(context, e);
    }
  }
}
