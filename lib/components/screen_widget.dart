import 'package:flutter/material.dart';
import 'package:lsd/lsd.dart';

import 'screen_provider.dart';
import 'screen_state.dart';

class ScreenWidget extends LsdWidget {
  late final String? title;
  late final LsdAction? onReady;
  late final LsdWidget? body;
  late final LsdWidget? leading;
  late final List<LsdWidget> actions;

  ScreenWidget(super.lsd);

  @override
  LsdWidget fromJson(Map<String, dynamic> props) {
    title = props["title"];
    body = props["body"] != null ? lsd.parseWidget(props["body"]!) : null;
    leading =
        props["leading"] != null ? lsd.parseWidget(props["leading"]!) : null;
    actions = List<Map<String, dynamic>>.from(props["actions"] ?? [])
        .map((e) => lsd.parseWidget(e))
        .toList();
    onReady =
        props["onReady"] != null ? lsd.parseAction(props["onReady"]!) : null;

    return super.fromJson(props);
  }

  @override
  Widget build(BuildContext context) {
    return _ScreenWidget(
      lsd: lsd,
      onReady: onReady,
      actions: actions,
      leading: leading,
      body: body,
      title: title,
    );
  }
}

class _ScreenWidget extends StatefulWidget {
  const _ScreenWidget({
    Key? key,
    required this.lsd,
    required this.actions,
    this.body,
    this.onReady,
    this.title,
    this.leading,
  }) : super(key: key);

  final Lsd lsd;
  final List<LsdWidget> actions;
  final LsdWidget? leading;
  final LsdWidget? body;
  final LsdAction? onReady;
  final String? title;

  @override
  State<_ScreenWidget> createState() => _ScreenWidgetState();
}

class _ScreenWidgetState extends State<_ScreenWidget> {
  late ScreenState _screenState;

  @override
  void initState() {
    super.initState();

    _screenState = ScreenState();
    Future.microtask(() => widget.onReady?.perform(() => context, null));
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.title != null ||
            widget.leading != null ||
            widget.actions.isNotEmpty
        ? AppBar(
            title: widget.title != null ? Text(widget.title!) : null,
            leading: widget.leading != null
                ? widget.leading!.toWidget(context)
                : null,
            actions: widget.actions.map((e) => e.toWidget(context)).toList(),
          )
        : null;

    return ScreenProvider(
      state: _screenState,
      child: ValueListenableBuilder<bool>(
        valueListenable: _screenState.busy,
        child: Scaffold(
          appBar: title,
          body: widget.body != null
              ? Builder(builder: widget.body!.toWidget)
              : null,
        ),
        builder: (context, busy, child) {
          return Stack(
            children: [
              child!,
              if (busy)
                const Opacity(
                  opacity: 0.3,
                  child: ModalBarrier(
                    dismissible: false,
                    color: Colors.black,
                  ),
                ),
              if (busy)
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
