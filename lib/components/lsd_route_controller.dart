import 'dart:async';

abstract class LsdRouteEvent {}

class LsdRouteEventLoad extends LsdRouteEvent {}

class LsdRouteController {
  LsdRouteController();

  final StreamController<LsdRouteEvent> _eventStreamController =
      StreamController.broadcast();

  Stream<LsdRouteEvent> get stream => _eventStreamController.stream;

  void load() {
    _eventStreamController.add(LsdRouteEventLoad());
  }
}
