import 'package:flutter/material.dart';
import 'package:lsd/lsd.dart';

import './form_widget.dart';

class InputWidget extends LsdWidget {
  late String name;
  late String? initialValue;
  late List<LsdAction> validations;

  InputWidget(super.serView);

  @override
  LsdWidget fromJson(Map<String, dynamic> props) {
    name = props["name"];
    initialValue = props["initialValue"];
    validations = List<Map<String, dynamic>>.from(props["validations"] ?? [])
        .map((e) => lsd.parseAction(e))
        .toList();
    return super.fromJson(props);
  }

  @override
  Widget build(BuildContext context) {
    FormDataWidget.of(context).register(name, validations);

    return _InputWidget(
      name: name,
      initialValue: initialValue ?? "",
    );
  }
}

class _InputWidget extends StatefulWidget {
  const _InputWidget({Key? key, required this.name, required this.initialValue})
      : super(key: key);
  final String name;
  final String initialValue;

  @override
  State<_InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<_InputWidget> {
  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    super.initState();

    _controller.text = widget.initialValue;

    _controller.addListener(() {
      FormDataWidget.of(context).setValue(widget.name, _controller.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: FormDataWidget.of(context).errors,
      builder: (context, Map<String, String> errors, child) {
        if (errors[widget.name] == null) {
          return child!;
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            child!,
            Text(
              errors[widget.name]!,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            )
          ],
        );
      },
      child: TextField(
        controller: _controller,
      ),
    );
  }
}
