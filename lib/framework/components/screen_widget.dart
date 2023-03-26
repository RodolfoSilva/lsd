import 'package:flutter/material.dart';
import 'package:lsd/lsd.dart';
import 'package:provider/provider.dart';

import '../providers/busy_controller.dart';
import 'parse_icon.dart';

class Tab {
  final String? title;
  final String? label;
  final IconData icon;
  final LsdWidget? widget;
  final LsdAction? overrideOnPress;

  Tab({
    this.title,
    this.label,
    required this.icon,
    this.widget,
    this.overrideOnPress,
  });

  factory Tab.fromJson(Lsd lsd, Map<String, dynamic> props) {
    return Tab(
      title: props["title"],
      label: props["label"],
      icon: parseIcon(props["icon"]),
      widget: lsd.parseWidgetOrNull(props["content"]),
      overrideOnPress: lsd.parseActionOrNull(props["override_on_press"]),
    );
  }
}

class ScreenWidget extends LsdWidget {
  late final String? title;
  late final LsdAction? onReady;
  late final LsdWidget? body;
  late final LsdWidget? leading;
  late final List<LsdWidget> actions;
  late final List<Tab> tabs;

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
    tabs = List<Map<String, dynamic>>.from(props["tabs"] ?? [])
        .map((e) => Tab.fromJson(lsd, e))
        .toList();
    onReady =
        props["on_ready"] != null ? lsd.parseAction(props["on_ready"]!) : null;

    return super.fromJson(props);
  }

  @override
  Widget build(BuildContext context) {
    return _ScreenWidget(
      lsd: lsd,
      onReady: onReady,
      actions: actions,
      leading: leading,
      tabs: tabs,
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
    required this.tabs,
    this.leading,
  }) : super(key: key);

  final Lsd lsd;
  final List<LsdWidget> actions;
  final LsdWidget? leading;
  final LsdWidget? body;
  final LsdAction? onReady;
  final String? title;
  final List<Tab> tabs;

  @override
  State<_ScreenWidget> createState() => _ScreenWidgetState();
}

class _ScreenWidgetState extends State<_ScreenWidget> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => widget.onReady?.perform(() => context, null));
  }

  @override
  Widget build(BuildContext context) {
    Widget? body;

    String? titleText = widget.title;
    Tab? currentTab;

    if (widget.tabs.isEmpty && widget.body != null) {
      body = widget.body!.toWidget(context);
    } else if (widget.tabs.isNotEmpty) {
      currentTab = widget.tabs[_selectedIndex];

      body = Builder(
        key: ValueKey(_selectedIndex),
        builder: (context) => currentTab!.widget!.toWidget(context),
      );

      titleText = currentTab.title;
    }

    final title = titleText != null ||
            widget.leading != null ||
            widget.actions.isNotEmpty
        ? AppBar(
            title: titleText != null ? Text(titleText) : null,
            leading: widget.leading != null
                ? widget.leading!.toWidget(context)
                : null,
            actions: widget.actions.map((e) => e.toWidget(context)).toList(),
          )
        : null;

    final busyController = context.watch<BusyController>();

    return Stack(
      children: [
        Scaffold(
          appBar: title,
          body: body,
          bottomNavigationBar: widget.tabs.isEmpty
              ? null
              : BottomNavigationBar(
                  items: widget.tabs
                      .map((e) => BottomNavigationBarItem(
                          icon: Icon(e.icon), label: e.label))
                      .toList(),
                  currentIndex: _selectedIndex,
                  type: BottomNavigationBarType.fixed,
                  onTap: (int index) async {
                    final tab = widget.tabs[index];
                    if (tab.overrideOnPress != null) {
                      await tab.overrideOnPress?.perform(() => context, null);
                    }

                    if (tab.widget == null) return;
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                ),
        ),
        if (busyController.isBusy('*'))
          const Opacity(
            opacity: 0.3,
            child: ModalBarrier(
              dismissible: false,
              color: Colors.black,
            ),
          ),
        if (busyController.isBusy('*'))
          const Center(child: CircularProgressIndicator()),
      ],
    );
  }
}
