import 'package:flutter/material.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'Messages.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late DialogFlowtter dialogFlowtter;
  final TextEditingController _controller = TextEditingController();

  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('chatbot')
      ),
      body: Container(
        color: Colors.grey.shade500,
        child: Column(
          children: [
            Expanded(child: MessagesScreen(messages: messages)),
            messageInputField(),
          ],
        ),
      ),
    );
  }

  Widget messageInputField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      color: Colors.green,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Message',
                hintStyle: TextStyle(color: Colors.white),
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              sendMessage(_controller.text);
              _controller.clear();
            },
            icon: Icon(Icons.send, color: Colors.white),
          ),
        ],
      ),
    );
  }

  sendMessage(String text) async {
    if(text.isEmpty) {
      print("Message is Empty");
      return;
    }
    setState(() {
      addMessage(Message(text: DialogText(text: [text])), true);
    });
    DetectIntentResponse response = await dialogFlowtter.detectIntent(
      queryInput: QueryInput(text: TextInput(text: text))
    );
    if (response.message == null) return;
    setState(() {
      addMessage(response.message!);
    });
  }

  addMessage(Message message, [bool isUserMessage = false]) {
    messages.add({
      'message': message,
      'isUserMessage': isUserMessage
    });
  }
}
