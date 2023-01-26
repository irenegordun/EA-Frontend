import 'package:flutter_front/widgets/message.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'json.dart';

class Websocket {
  IOWebSocketChannel channel =
      IOWebSocketChannel.connect("http://localhost:3000");
  String serverHostname = "";
  String serverPort = "";

  Websocket(String serverHostname, String serverPort) {
    this.serverHostname = serverHostname;
    this.serverPort = serverPort;
    this.channel = IOWebSocketChannel.connect('$serverHostname$serverPort');
  }

  void disconnectFromServer() {
    // TODO: error handling, for now it will crash and burn
    channel.sink.close(status.goingAway);
  }

  void listenForMessages(void onMessageReceived(dynamic String)) {
    // TODO: error handling, for now it will crash and burn
    channel.stream.listen(onMessageReceived);
    print('now listening for messages');
  }

  void sendMessage(String message) {
    print('sending a message: ' + message);
    // TODO: error handling, for now it will crash and burn
    channel.sink.add(Json.encodeMessageJSON(message));
  }
}
