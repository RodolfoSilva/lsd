# LSD FORM CLIENT

**DON'T USE THIS PROJECT IN PRODUCTION**, I am not responsible if you use it in production, use it at your own risk.

## Features

Convert the server UI to Flutter UI

## Usage

```dart
import 'package:flutter/material.dart';
import 'package:lsd/lsd.dart';
import 'package:lsd_form/lsd_form.dart';

void main() async {
  final lsd = Lsd(
    widgetParser: DefaultLsdWidgetParser(
      widgetsShelf: LsdWidgetsShelf()
        ..register("Form", LsdFormWidget.new)
        ..register("Input", InputWidget.new)
        ..register("Button", ButtonWidget.new)
    ),
    actionParser: DefaultLsdActionParser(
      actionsShelf: LsdActionsShelf()
        ..register("SubmitForm", LsdSubmitFormAction.new),
    ),
    buildLoadingWidget: () => const LoadingWidget(),
    buildErrorWidget: () => Material(
      child: Container(
        child: const Text(
          "Error",
          textAlign: TextAlign.center,
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
      "component": "Container",
      "props": {
        "child": {
          "component": "Form",
          "props": {
            "child": {
              "component": "Column",
              "props": {
                "children": [
                  {
                    "component": "Input",
                    "props": {
                      "name": "name",
                      "label": "Hello",
                      "initialValue": "World",
                    },
                  },
                  {
                    "component": "Button",
                    "props": {
                      "child": {
                        "component": "Text",
                        "props": {
                          "text": "Hello World",
                        },
                      },
                    },
                  },
                ],
              },
            },
          },
        },
      },
    }).toWidget(context);
  }
}

class InputWidget extends LsdWidget {
  late String name;
  late LsdWidget? label;
  late String? initialValue;
  late bool obscure;
  late List<LsdAction> validations;

  InputWidget(super.lsd);

  @override
  LsdWidget fromJson(Map<String, dynamic> props) {
    name = props["name"];
    obscure = props["obscure"] ?? false;
    label = props["label"] != null ? lsd.parseWidget(props["label"]) : null;
    initialValue = props["initialValue"];
    validations = List<Map<String, dynamic>>.from(props["validations"] ?? []).map((e) => lsd.parseAction(e)).toList();
    return super.fromJson(props);
  }

  @override
  Widget build(BuildContext context) {
    return LsdFormFieldWidgetBuilder(
      name: name,
      initialValue: initialValue,
      validations: validations,
      builder: (context, controller, error, child) {
        return TextField(
          controller: controller,
          obscureText: obscure,
          decoration: InputDecoration(
              label: label?.toWidget(context), errorText: error),
        );
      },
    );
  }
}


class ButtonWidget extends LsdWidget {
  late final LsdWidget child;
  late final LsdAction? onPress;
  late String variant;

  ButtonWidget(super.lsd);

  @override
  LsdWidget fromJson(Map<String, dynamic> props) {
    child = lsd.parseWidget(props["child"]);
    onPress =  props["onPress"] != null ? lsd.parseAction(props["onPress"]) : null;
    return super.fromJson(props);
  }

  @override
  Widget build(BuildContext context) {
    final formData = context.dependOnInheritedWidgetOfExactType<LsdFormProvider>();

    if (formData != null) {
      return ValueListenableBuilder<bool>(
        valueListenable: LsdFormProvider.of(context).submitting,
        child: child.toWidget(context),
        builder: (context, submitting, child) => internalBuild(
          context,
          submitting: submitting,
          child: child!,
        ),
      );
    }

    return internalBuild(
      context,
      child: child.toWidget(context),
    );
  }

  Widget internalBuild(
    BuildContext context, {
    bool submitting = false,
    required Widget child,
  }) {
    final finalChild = submitting
        ? const SizedBox(
            height: 15,
            width: 15,
            child: CircularProgressIndicator(color: Colors.white))
        : child;

    final onPress = submitting ? () => null : () => this.onPress?.perform(getContext, null);

    return ElevatedButton(
      onPressed: onPress,
      child: finalChild,
    );
  }
}

```
