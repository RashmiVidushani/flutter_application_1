import 'package:flutter/material.dart';
import 'package:flutter_application_1/CustomCardUI/buttoncard.dart';
import 'package:flutter_application_1/Model/chatmodel.dart';
import 'package:flutter_application_1/Screens/homescreen.dart';
import 'package:flutter_application_1/Screens/selectcontact.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late ChatModel sourceChat;
  List<ChatModel> chats = [
    ChatModel(
        name: "Dev Stack",
        isGroup: false,
        currentMessage: "hi",
        time: "2:10pm",
        icon: "person_black_24dp.svg",
        id: 1),
    ChatModel(
        name: "test2",
        isGroup: false,
        currentMessage: "hi",
        time: "5:10pm",
        icon: "person_black_24dp.svg",
        id: 2),
    ChatModel(
        name: "test3",
        isGroup: false,
        currentMessage: "hi",
        time: "6:10pm",
        icon: "person_black_24dp.svg",
        id: 3),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            itemCount: chats.length,
            itemBuilder: (context, index) => InkWell(
                onTap: () {
                  sourceChat = chats.removeAt(index);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => HomeScreen(
                                chats: chats,
                                sourceChat: sourceChat,
                              )));
                },
                child:
                    ButtonCard(name: chats[index].name!, icon: Icons.person))));
  }
}
