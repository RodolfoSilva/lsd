import 'package:flutter/material.dart';
import 'package:lsd/lsd.dart';
import 'package:serview/actions/send_to_server.dart';
import 'package:serview/components/center_widget.dart';
import 'package:serview/components/dynamic_widget.dart';

import 'actions/dialog.dart';
import 'actions/navigate.dart';
import 'actions/required_validation.dart';
import 'components/button_widget.dart';
import 'components/column_widget.dart';
import 'components/container_widget.dart';
import 'components/input_widget.dart';
import 'components/screen_widget.dart';
import 'components/text_widget.dart';
import 'loader.dart';
import 'loading_widget.dart';
import 'lsd_form/lsd_form_widget.dart';
import 'lsd_form/lsd_submit_form.dart';

void main() {
  final lsd = Lsd(
    widgetParser: DefaultLsdWidgetParser(
      widgetsShelf: LsdWidgetsShelf()
        ..register("Dynamic", DynamicWidget.new)
        ..register("Container", ContainerWidget.new)
        ..register("Center", CenterWidget.new)
        ..register("Column", ColumnWidget.new)
        ..register("Button", ButtonWidget.new)
        ..register("Form", LsdFormWidget.new)
        ..register("Input", InputWidget.new)
        ..register("Screen", ScreenWidget.new)
        ..register("Text", TextWidget.new),
    ),
    actionParser: DefaultLsdActionParser(
      actionsShelf: LsdActionsShelf()
        ..register(
          "SendToServer",
          (lsd) => SendToServerAction(lsd, ApiService()),
        )
        ..register("Navigate", NavigateAction.new)
        ..register("ShowDialog", ShowDialogAction.new)
        ..register("RequiredValidation", RequiredValidationAction.new)
        ..register("SubmitForm", LsdSubmitFormAction.new),
    ),
    buildLoadingWidget: () => const LoadingWidget(),
    buildErrorWidget: () => Material(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            SizedBox(width: double.infinity),
            Text(
              "Ocorreu um erro",
              textAlign: TextAlign.center,
            ),
            Text(
              "Não foi possível carregar as informações.",
              textAlign: TextAlign.center,
            ),
            Text(
              "Verifique sua conexão e tente novamente",
              textAlign: TextAlign.center,
            ),
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
    }).toWidth(context);
  }
}
