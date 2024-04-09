import 'package:web_socket_channel/web_socket_channel.dart';

final class MessageWebsocket {
  final WebSocketChannel _channel;

  MessageWebsocket._()
      : _channel = WebSocketChannel.connect(
          Uri.parse("wss://echo.websocket.org/"),
        );

  static Future<MessageWebsocket> connect() async {
    final websocket = MessageWebsocket._();
    await websocket._channel.ready;
    return websocket;
  }

  Future<void> close() async {
    await _channel.sink.close();
  }

  void send(String message) {
    _channel.sink.add(message);
  }

  Stream<String> get stream => _channel.stream.cast();
}
