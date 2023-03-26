import 'package:lsd/lsd.dart';

class LoadMoreActionResult extends LsdAction {
  LoadMoreActionResult(super.lsd);

  late final Map<String, dynamic> result;

  @override
  LsdAction fromJson(Map<String, dynamic> props) {
    result = {
      "items": List<Map<String, dynamic>>.from(props["items"])
          .map((e) => lsd.parseWidget(e))
          .toList(),
      "on_load_more": props["on_load_more"] != null
          ? lsd.parseAction(props["on_load_more"])
          : null,
    };

    return super.fromJson(props);
  }

  @override
  Future<dynamic> perform(GetContext getContext, dynamic params) async {
    return result;
  }
}
