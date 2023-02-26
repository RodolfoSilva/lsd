import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lsd/lsd.dart';
import 'package:lsd_form/lsd_form.dart';

import 'actions/action_result.dart';
import 'actions/auth_set_token.dart';
import 'actions/dialog.dart';
import 'actions/get_from_server.dart';
import 'actions/if.dart';
import 'actions/load_more_result.dart';
import 'actions/navigate.dart';
import 'actions/required_validation.dart';
import 'actions/send_to_server.dart';
import 'api_service.dart';
import 'auth.dart';
import 'components/button_widget.dart';
import 'components/card_widget.dart';
import 'components/center_widget.dart';
import 'components/column_widget.dart';
import 'components/container_widget.dart';
import 'components/divider_widget.dart';
import 'components/dynamic_widget.dart';
import 'components/expanded_widget.dart';
import 'components/input_widget.dart';
import 'components/list_view_widget.dart';
import 'components/lsd_route_controller_provider.dart';
import 'components/row_widget.dart';
import 'components/screen_widget.dart';
import 'components/text_widget.dart';
import 'loading_widget.dart';
import 'secure_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // final storage = SharedStorage(await SharedPreferences.getInstance());

  const storage = SecureStorage(FlutterSecureStorage());

  final auth = Auth(storage);
  final apiService = ApiService(auth);

  final lsd = Lsd(
    widgetParser: DefaultLsdWidgetParser(
      widgetsShelf: LsdWidgetsShelf()
        ..register("Dynamic", (lsd) => DynamicWidget(lsd, apiService))
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
    actionParser: DefaultLsdActionParser(
      actionsShelf: LsdActionsShelf()
        ..register(
          "SendToServer",
          (lsd) => SendToServerAction(lsd, apiService),
        )
        ..register(
          "GetFromServer",
          (lsd) => GetFromServerAction(lsd, apiService),
        )
        ..register("AuthSetToken", (lsd) => AuthSetTokenAction(lsd, auth))
        ..register("LoadMoreResult", LoadMoreActionResult.new)
        ..register("Result", ActionResult.new)
        ..register("If", IfAction.new)
        ..register("Navigate", NavigateAction.new)
        ..register("ShowDialog", ShowDialogAction.new)
        ..register("RequiredValidation", RequiredValidationAction.new)
        ..register("SubmitForm", LsdSubmitFormAction.new),
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
            Builder(builder: (context) {
              return ElevatedButton(
                child: const Text("Tentar novamente"),
                onPressed: () => LsdRouteControllerProvider.of(context).load(),
              );
            }),
          ],
        ),
      ),
    ),
  );

  runApp(MyApp(lsd: lsd));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.lsd}) : super(key: key);

  final Lsd lsd;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(lsd: lsd),
        '/about': (context) => const MyWidget(),
      },
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Native Flutter Screen'),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.lsd}) : super(key: key);

  final Lsd lsd;
  @override
  Widget build(BuildContext context) {
    return lsd.parseWidget({
      "component": "Dynamic",
      "props": {
        "path": "/api/main",
      }
    }).toWidget(context);
  }
}
