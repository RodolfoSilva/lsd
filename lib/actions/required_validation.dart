import 'package:lsd/lsd.dart';
import 'package:lsd_form/lsd_form.dart';

class RequiredValidationAction extends LsdAction {
  RequiredValidationAction(super.lsd);

  late String message;

  @override
  LsdAction fromJson(Map<String, dynamic> props) {
    message = props["message"] ?? "Required!";

    return super.fromJson(props);
  }

  @override
  Future<dynamic> perform(GetContext getContext, dynamic params) async {
    if (params == null) {
      return LsdValidationResult.invalid(message);
    }

    if (params is String && params.isEmpty) {
      return LsdValidationResult.invalid(message);
    }

    return LsdValidationResult.valid();
  }
}
