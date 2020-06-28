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
  var params;

  PageEvent(this.params);
}
/**
 * 用法
 * StreamSubscription<PageEvent> _bus;
 * _bus=EventBusUtil.getInstance().on<PageEvent>().listen((data) {
    print(data.params);
    _bus.cancel();
    setState(() {
    widget.value = data.params['name'];
    });
    widget.onChange(data.params);
    });
 * EventBusUtil.getInstance().fire(PageEvent(res));
 *  */
