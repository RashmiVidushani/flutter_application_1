import 'package:flutter/material.dart';
import 'package:flutter_application_1/CustomCardUI/customcard.dart';
import 'package:flutter_application_1/Model/chatmodel.dart';
import 'package:flutter_application_1/Screens/selectcontact.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key, this.chats, this.sourceChat}) : super(key: key);
  final List<ChatModel>? chats;
  final ChatModel? sourceChat;
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatModel> chats = [
    ChatModel(
        name: "Dev Stack",
        isGroup: false,
        currentMessage: "hi",
        time: "2:10pm",
        icon: "person_black_24dp.svg"),
    ChatModel(
        name: "test",
        isGroup: true,
        currentMessage: "hi",
        time: "5:10pm",
        icon: "groups_black_24dp.svg"),
    ChatModel(
        name: "test1",
        isGroup: true,
        currentMessage: "hi",
        time: "10:10pm",
        icon: "groups_black_24dp.svg"),
    ChatModel(
        name: "test2",
        isGroup: false,
        currentMessage: "hi",
        time: "5:10pm",
        icon: "person_black_24dp.svg"),
    ChatModel(
        name: "test3",
        isGroup: false,
        currentMessage: "hi",
        time: "6:10pm",
        icon: "person_black_24dp.svg"),
    ChatModel(
        name: "test4",
        isGroup: true,
        currentMessage: "hi",
        time: "9:10pm",
        icon: "groups_black_24dp.svg")
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (builder) => const SelectContact()));
        },
        child: const Icon(
          Icons.chat,
          color: Colors.white,
        ),
      ),
      body: ListView.builder(
        itemCount: widget.chats!.length,
        itemBuilder: (context, index) => CustomCard(
          chatModel: widget.chats![index],
          sourceChat: widget.sourceChat,
        ),
      ),
    );
  }
}
