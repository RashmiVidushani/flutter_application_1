//flutter run --no-sound-null-safety

//Flutter Phone Authentication | Implementing Phone Auth Using Flutter & Firebase + Source Code

/*import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/chatmodel.dart';
import 'package:flutter_application_1/NewScreen/call_screen.dart';
import 'package:flutter_application_1/Pages/assignment.dart';
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
  late String uid;
  late TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this, initialIndex: 1);
    uid = FirebaseAuth.instance.currentUser!.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(uid),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          PopupMenuButton(
            onSelected: (value) {
              print(value);
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  child: Text("New group"),
                  value: "New group",
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
      ),
      bottomNavigationBar: menu(),
      body: TabBarView(controller: _controller, children: [
        CamaraPage(),
        Assignment(),
        /*ChatPage(
          chats: widget.chats,
          sourceChat: widget.sourceChat,
        ),*/
        StatusPage(),
        CallScreen(),
      ]),
    );
  }

  Widget menu() {
    return Container(
      color: Colors.orange,
      child: TabBar(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white70,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: EdgeInsets.all(5.0),
        indicatorColor: Color.fromARGB(255, 240, 243, 245),
        controller: _controller,
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
    );
  }
}
 */







//Easy Flutter Firebase Phone Number Authentication - Flutter Chat App Firebase