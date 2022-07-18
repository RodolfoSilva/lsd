import 'package:lsd/lsd.dart';

class LoadMoreResultAction extends LsdAction {
  LoadMoreResultAction(super.lsd);

  late final Map<String, dynamic> result;

  @override
  LsdAction fromJson(Map<String, dynamic> props) {
    result = {
      "items": List<Map<String, dynamic>>.from(props["items"])
          .map((e) => lsd.parseWidget(e))
          .toList(),
      "onLoadMore": props["onLoadMore"] != null
          ? lsd.parseAction(props["onLoadMore"])
          : null,
    };

    return super.fromJson(props);
  }

  @override
  Future<dynamic> perform(GetContext getContext, dynamic params) async {
    return result;
  }
}
