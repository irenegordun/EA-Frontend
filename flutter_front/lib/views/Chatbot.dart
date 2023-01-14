import 'package:dialogflow_flutter/googleAuth.dart';
import 'package:flutter/material.dart';
import '../widgets/message.dart';
import 'package:dialogflow_flutter/dialogflowflutter.dart';

class ChatBot extends StatefulWidget {
  ChatBot({super.key, this.title = "Chatbot"});

  final String title;

  @override
  _ChatBotState createState() => new _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  final List<Message> messageList = <Message>[];
  final TextEditingController _textController = new TextEditingController();

  Widget _queryInputWidget(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _submitQuery,
                decoration:
                    InputDecoration.collapsed(hintText: "Send a message"),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                  icon: Icon(
                    Icons.send,
                    color: Colors.green[400],
                  ),
                  onPressed: () => _submitQuery(_textController.text)),
            ),
          ],
        ),
      ),
    );
  }

  void agentResponse(query) async {
    _textController.clear();
    AuthGoogle authGoogle =
        await AuthGoogle(fileJson: "newagent-lctw-bb7b7319022e.json").build();
    DialogFlow dialogFlow = DialogFlow(authGoogle: authGoogle, language: "es");
    AIResponse response = await dialogFlow.detectIntent(query);
    Message message = Message(
      text: response.getMessage() ?? "No message available",
      name: "Flutter",
      type: false,
    );
    setState(() {
      messageList.insert(0, message);
    });
  }

  void _submitQuery(String text) {
    _textController.clear();
    Message message = new Message(
      text: text,
      name: "User",
      type: true,
    );
    setState(() {
      messageList.insert(0, message);
    });
    agentResponse(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "ChatBot",
        ),
        backgroundColor: Color.fromRGBO(96, 125, 139, 1),
      ),
      body: Column(children: <Widget>[
        Flexible(
            child: ListView.builder(
          padding: EdgeInsets.all(8.0),
          reverse: true, //To keep the latest messages at the bottom
          itemBuilder: (_, int index) => messageList[index],
          itemCount: messageList.length,
        )),
        _queryInputWidget(context),
      ]),
    );
  }
}
