import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lsd/lsd.dart';
import 'package:lsd_form/lsd_form.dart';
import 'package:provider/provider.dart';

import '../actions/auth_access_token.dart';
import '../actions/dialog.dart';
import '../actions/if.dart';
import '../actions/load_more_result.dart';
import '../actions/navigate.dart';
import '../actions/refresh_page.dart';
import '../actions/required_validation.dart';
import '../actions/send_request.dart';
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
import '../secure_storage.dart';
import '../services/api_service.dart';
import '../services/auth_interceptor.dart';
import '../services/auth_service.dart';
import '../storage.dart';
import '../widgets/error_widget.dart';
import '../widgets/loading_screen_widget.dart';

final lsdProviders = [
  Provider<Storage>(
    create: (context) => const SecureStorage(FlutterSecureStorage()),
  ),
  ProxyProvider<Storage, AuthService>(
    update: (context, storage, previous) => AuthService(storage),
  ),
  ProxyProvider<AuthService, Dio>(
    update: (context, authService, previous) => Dio(
      BaseOptions(
        baseUrl: Platform.isAndroid
            ? 'http://10.0.2.2:4000'
            : 'http://localhost:4000',
        connectTimeout: 10000,
        receiveTimeout: 60000,
      ),
    )..interceptors.add(AuthInterceptor(authService: authService)),
  ),
  ProxyProvider<Dio, ApiService>(
    update: (context, dio, previous) => ApiService(dio: dio),
  ),
  ProxyProvider2<ApiService, AuthService, Lsd>(
    update: (context, apiService, authService, previous) {
      final actionsShelf = LsdActionsShelf()
        ..register("SendRequest", SendRequestAction.new)
        ..register("RefreshPage", RefreshPageAction.new)
        ..register("AuthAccessToken", AuthAccessTokenAction.new)
        ..register("LoadMoreResult", LoadMoreActionResult.new)
        ..register("Navigate", NavigateAction.new)
        ..register("ShowDialog", ShowDialogAction.new)
        ..register("RequiredValidation", RequiredValidationAction.new)
        ..register("SubmitForm", LsdSubmitFormAction.new)
        ..register("If", IfAction.new);

      final widgetsShelf = LsdWidgetsShelf()
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
        ..register("Text", TextWidget.new);

      return Lsd(
        actionParser: DefaultLsdActionParser(actionsShelf: actionsShelf),
        widgetParser: DefaultLsdWidgetParser(widgetsShelf: widgetsShelf),
        buildLoadingWidget: () => const LoadingScreenWidget(),
        buildErrorWidget: (error) => ErrorScreenWidget(error: error),
      );
    },
  ),
];
