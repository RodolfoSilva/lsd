import 'package:flutter/material.dart';
import 'package:lsd/lsd.dart';
import 'package:serview/actions/required_validation.dart';
import 'package:serview/actions/submit_form.dart';
import 'package:serview/components/container_widget.dart';

import 'actions/dialog.dart';
import 'actions/navigate.dart';
import 'components/button_widget.dart';
import 'components/column_widget.dart';
import 'components/form_widget.dart';
import 'components/input_widget.dart';
import 'components/screen_widget.dart';
import 'components/text_widget.dart';
import 'loader.dart';
import 'loading_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final lsd = Lsd(
    widgetParser: DefaultLsdWidgetParser(
      widgetsShelf: LsdWidgetsShelf()
        ..register("Container", ContainerWidget.new)
        ..register("Column", ColumnWidget.new)
        ..register("Button", ButtonWidget.new)
        ..register("Form", FormWidget.new)
        ..register("Input", InputWidget.new)
        ..register("Screen", ScreenWidget.new)
        ..register("Text", TextWidget.new),
    ),
    actionParser: DefaultLsdActionParser(
      actionsShelf: LsdActionsShelf()
        ..register("Navigate", NavigateAction.new)
        ..register("ShowDialog", ShowDialogAction.new)
        ..register("RequiredValidation", RequiredValidationAction.new)
        ..register("SubmitForm", SubmitFormAction.new),
    ),
    buildLoadingWidget: () => const LoadingWidget(),
    buildErrorWidget: () => Scaffold(
      body: Column(
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
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: load("/main"),
      builder: (context, data) {
        if (data.connectionState != ConnectionState.done) {
          return lsd.renderLoading(context);
        }

        if (data.hasError) {
          return lsd.renderError(context, data.error);
        }
        return LsdSafeWidgetBuilder(
          lsd: lsd,
          element: data.data!,
        );
      },
    );
  }
}
