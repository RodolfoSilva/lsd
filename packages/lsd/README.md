# LSD

**DON'T USE THIS PROJECT IN PRODUCTION**, I am not responsible if you use it in production, use it at your own risk.

## Features

Convert the server UI to Flutter UI

## Usage

```dart
import 'package:flutter/material.dart';
import 'package:lsd/lsd.dart';

void main() async {
  final lsd = Lsd(
    widgetParser: DefaultLsdWidgetParser(
      widgetsShelf: LsdWidgetsShelf()
        ..register("Container", ContainerWidget.new),
        ..register("Text", TextWidget.new),
    ),
    actionParser: DefaultLsdActionParser(
      actionsShelf: LsdActionsShelf(),
    ),
    buildLoadingWidget: () => const LoadingWidget(),
    buildErrorWidget: () => Material(
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
              "Unable to load the information.",
              textAlign: TextAlign.center,
            ),
            const Text(
              "Check your connection and try again.",
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
      "component": "Container",
      "props": {
        "child": {
          "component": "Text",
          "props": {
            "text": "Hello World",
          },
        },
      },
    }).toWidget(context);
  }
}

class TextWidget extends LsdWidget {
  late String text;

  TextWidget(super.lsd);

  @override
  LsdWidget fromJson(Map<String, dynamic> props) {
    text = props["text"];
    return super.fromJson(props);
  }

  @override
  Widget build(BuildContext context) {
    return Text(text);
  }
}

class ContainerWidget extends LsdWidget {
  late LsdWidget child;
  late int padding;

  ContainerWidget(super.lsd);

  @override
  LsdWidget fromJson(Map<String, dynamic> props) {
    child = lsd.parseWidget(props["child"]);
    padding = props["padding"] ?? 0;
    return super.fromJson(props);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding.toDouble()),
      child: child.toWidget(context),
    );
  }
}
```
