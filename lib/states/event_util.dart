import 'package:event_bus/event_bus.dart';
export 'dart:async';

class EventBusUtil {
  static EventBus _eventBus;

  static EventBus getInstance() {
    if (_eventBus == null) {
      _eventBus = new EventBus();
    }
    return _eventBus;
  }
}

class PageEvent {
  String name;
  Map data;

  PageEvent({this.name, this.data});
}
/**
 * 用法
 * StreamSubscription<PageEvent> _bus;
 * _bus=EventBusUtil.getInstance().on<PageEvent>().listen((data) {
    if (data.name != 'Message') {
    return;
    }
    print(data.name);
    _bus.cancel();
    setState(() {
    widget.value = data.data['name'];
    });
    widget.onChange(data.data);
    });
 * EventBusUtil.getInstance().fire(PageEvent(res));
 *  */
