import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lsd/lsd.dart';
import 'package:lsd_form/lsd_form.dart';
import 'package:provider/provider.dart';

import '../actions/action_result.dart';
import '../actions/auth_set_token.dart';
import '../actions/dialog.dart';
import '../actions/get_from_server.dart';
import '../actions/if.dart';
import '../actions/load_more_result.dart';
import '../actions/navigate.dart';
import '../actions/refresh_page.dart';
import '../actions/required_validation.dart';
import '../actions/send_to_server.dart';
import '../components/button_widget.dart';
import '../components/card_widget.dart';
import '../components/center_widget.dart';
import '../components/column_widget.dart';
import '../components/container_widget.dart';
import '../components/divider_widget.dart';
import '../components/dynamic_widget.dart';
import '../components/expanded_widget.dart';
import '../components/input_widget.dart';
import '../components/list_view_widget.dart';
import '../components/row_widget.dart';
import '../components/screen_widget.dart';
import '../components/text_widget.dart';
import '../loading_widget.dart';
import '../lsd_page_controller.dart';
import '../secure_storage.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';
import '../storage.dart';

final lsdProviders = [
  Provider<Storage>(
    create: (context) => const SecureStorage(FlutterSecureStorage()),
  ),
  ProxyProvider<Storage, AuthService>(
    update: (context, storage, previous) => AuthService(storage),
  ),
  ProxyProvider<AuthService, ApiService>(
    update: (context, auth, previous) => ApiService(auth),
  ),
  ProxyProvider2<ApiService, AuthService, Lsd>(
    update: (context, apiService, authService, previous) {
      return Lsd(
        actionParser: DefaultLsdActionParser(
          actionsShelf: LsdActionsShelf()
            ..register("SendToServer", SendToServerAction.new)
            ..register("GetFromServer", GetFromServerAction.new)
            ..register("RefreshPage", RefreshPageAction.new)
            ..register("AuthSetToken", AuthSetTokenAction.new)
            ..register("LoadMoreResult", LoadMoreActionResult.new)
            ..register("Result", ActionResult.new)
            ..register("If", IfAction.new)
            ..register("Navigate", NavigateAction.new)
            ..register("ShowDialog", ShowDialogAction.new)
            ..register("RequiredValidation", RequiredValidationAction.new)
            ..register("SubmitForm", LsdSubmitFormAction.new),
        ),
        widgetParser: DefaultLsdWidgetParser(
          widgetsShelf: LsdWidgetsShelf()
            ..register("Dynamic", DynamicWidget.new)
            ..register("Container", ContainerWidget.new)
            ..register("Center", CenterWidget.new)
            ..register("Column", ColumnWidget.new)
            ..register("Button", ButtonWidget.new)
            ..register("Form", LsdFormWidget.new)
            ..register("ListView", ListViewWidget.new)
            ..register("Expanded", ExpandedWidget.new)
            ..register("Input", InputWidget.new)
            ..register("Card", CardWidget.new)
            ..register("Row", RowWidget.new)
            ..register("Divider", DividerWidget.new)
            ..register("Screen", ScreenWidget.new)
            ..register("Text", TextWidget.new),
        ),
        buildLoadingWidget: () => const LoadingWidget(),
        buildErrorWidget: (error) => Material(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: double.infinity),
                const Text(
                  "Ocorreu um erro",
                  textAlign: TextAlign.center,
                ),
                const Text(
                  "Não foi possível carregar as informações.",
                  textAlign: TextAlign.center,
                ),
                const Text(
                  "Verifique sua conexão e tente novamente",
                  textAlign: TextAlign.center,
                ),
                ElevatedButton(
                  child: const Text("Tentar novamente"),
                  onPressed: () => context.read<LsdPageController>().refresh(),
                ),
              ],
            ),
          ),
        ),
      );
    },
  ),
];
