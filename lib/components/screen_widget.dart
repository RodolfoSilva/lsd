import 'package:flutter/material.dart';
import 'package:lsd/lsd.dart';

import 'screen_inherited_widget.dart';
import 'screen_state.dart';

class ScreenWidget extends LsdWidget {
  late final String? title;
  late final LsdWidget? body;

  ScreenWidget(super.lsd);

  @override
  LsdWidget fromJson(Map<String, dynamic> props) {
    title = props["title"];
    body = props["body"] != null ? lsd.parseWidget(props["body"]!) : null;

    return super.fromJson(props);
  }

  @override
  Widget build(BuildContext context) {
    final title = this.title != null ? AppBar(title: Text(this.title!)) : null;

    return _ScreenWidget(
      lsd: lsd,
      child: Scaffold(
        appBar: title,
        body: body != null
            ? Builder(builder: (context) => body!.toWidth(context))
            : null,
      ),
    );
  }
}

class _ScreenWidget extends StatefulWidget {
  const _ScreenWidget({
    Key? key,
    required this.lsd,
    required this.child,
  }) : super(key: key);

  final Lsd lsd;
  final Widget child;

  @override
  State<_ScreenWidget> createState() => _ScreenWidgetState();
}

class _ScreenWidgetState extends State<_ScreenWidget> {
  late ScreenState _screenState;

  @override
  void initState() {
    super.initState();

    _screenState = ScreenState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenInheritedWidget(
      // lsd: widget.lsd,
      state: _screenState,
      child: ValueListenableBuilder<bool>(
        valueListenable: _screenState.busy,
        child: widget.child,
        builder: (context, busy, child) {
          return Stack(
            children: [
              child!,
              if (_screenState.isBusy)
                const Opacity(
                  opacity: 0.3,
                  child: ModalBarrier(dismissible: false, color: Colors.black),
                ),
              if (_screenState.isBusy)
                const Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          );
        },
      ),
    );
  }
}
