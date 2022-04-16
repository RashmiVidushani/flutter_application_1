import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/chatmodel.dart';
import 'package:flutter_application_1/NewScreen/call_screen.dart';
import 'package:flutter_application_1/Pages/camarapage.dart';
import 'package:flutter_application_1/Pages/chatpage.dart';
import 'package:flutter_application_1/Pages/status.dart';
import 'package:flutter_application_1/Screens/loginscreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, this.chats, this.sourceChat}) : super(key: key);
  final List<ChatModel>? chats;
  final ChatModel? sourceChat;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this, initialIndex: 1);
  }

  var selectedItem = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text(user!.uid),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          PopupMenuButton(
            onSelected: (value) {
              setState(() {
                selectedItem = value.toString();
              });
              print(value);
              Navigator.pushNamed(context, value.toString());
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  child: Text("Profile"),
                  value: "/profile",
                ),
                const PopupMenuItem(
                  child: Text("New broadcast"),
                  value: "New broadcast",
                ),
                const PopupMenuItem(
                  child: Text("Whatsapp Web"),
                  value: "Whatsapp Web",
                ),
                const PopupMenuItem(
                  child: Text("Starred messages"),
                  value: "Starred messages",
                ),
                const PopupMenuItem(
                  child: Text("Settings"),
                  value: "Settings",
                ),
                PopupMenuItem(
                    child: GestureDetector(
                        onTap: () async {
                          // await _auth.signOut();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        child: Text(
                          "Logout",
                        ))),
              ];
            },
          )
        ],
        bottom: TabBar(
          controller: _controller,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(
              icon: Icon(Icons.camera_alt),
            ),
            Tab(
              text: "CHATS",
            ),
            Tab(
              text: "STATUS",
            ),
            Tab(
              text: "CALLS",
            )
          ],
        ),
      ),
      body: TabBarView(controller: _controller, children: [
        CamaraPage(),
        ChatPage(
          chats: widget.chats,
          sourceChat: widget.sourceChat,
        ),
        StatusPage(),
        CallScreen(),
      ]),
    );
  }
}
