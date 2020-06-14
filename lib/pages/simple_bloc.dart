import 'dart:async';

class SimpleBloc<T>{
  final _controller = StreamController<T>();
  Stream <T> get stream => _controller.stream;

  void add(T event) {
    _controller.sink.add(event);
  }

  void addError(Object error, [StackTrace stackTrace]){
    _controller.addError(error, stackTrace);
  }

  void dispose() {
    _controller.close();
  }
}