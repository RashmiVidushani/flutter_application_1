import 'dart:convert';
import 'package:emoji_picker_2/emoji_picker_2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/CustomCardUI/ownmessagecard.dart';
import 'package:flutter_application_1/CustomCardUI/replycard.dart';
import 'package:flutter_application_1/Model/chatmodel.dart';
import 'package:flutter_application_1/Model/chatmodel.dart';
import 'package:flutter_application_1/Model/messagemodel.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class IndividualPage extends StatefulWidget {
  const IndividualPage({Key? key, this.chatModel, this.sourceChat})
      : super(key: key);
  final ChatModel? chatModel;
  final ChatModel? sourceChat;

  @override
  State<IndividualPage> createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  bool show = false;
  FocusNode focusNode = FocusNode();
  TextEditingController _controller = TextEditingController();
  late IO.Socket socket;
  bool sendButton = false;

  List<MessageModel> messages = [];

  @override
  void initState() {
    super.initState();
    connect();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });
  }

  void connect() {
    socket = IO.io("http://192.168.8.228:5000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect();
    socket.emit("signin", widget.sourceChat!.id);
    socket.onConnect((data) {
      print("connected");
      socket.on("message", (msg) {
        print(msg);
        setMessage("destination", msg["message"]);
      });
    });
    print(socket.connected);
  }

  void sendMessage(String message, int sourceId, int targetId) {
    setMessage("source", message);
    socket.emit("message",
        {"message": message, "sourceId": sourceId, "targetId": targetId});
  }

  void setMessage(String type, String message) {
    MessageModel messageModel = MessageModel(type: type, message: message);
    setState(() {
      setState(() {
        messages.add(messageModel);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset("assets/backimage.png",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leadingWidth: 70,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Icon(
                  Icons.arrow_back,
                  size: 24,
                ),
                CircleAvatar(
                  child: SvgPicture.asset(
                    widget.chatModel!.isGroup!
                        ? "assets/groups_black_24dp.svg"
                        : "assets/person_black_24dp.svg",
                    color: Colors.white,
                    height: 36,
                    width: 36,
                  ),
                  radius: 20,
                  backgroundColor: Colors.blueGrey,
                )
              ]),
            ),
            title: InkWell(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.all(6),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.chatModel!.name!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Text("Last seen today at 12:23pm",
                          style: TextStyle(fontSize: 12))
                    ]),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.videocam),
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.call)),
              PopupMenuButton<String>(
                onSelected: (value) {
                  print(value);
                },
                itemBuilder: (BuildContext contesxt) {
                  return [
                    const PopupMenuItem(
                      child: Text("View contact"),
                      value: "View contact",
                    ),
                    const PopupMenuItem(
                      child: Text("Media, links and docs"),
                      value: "Media, links and docs",
                    ),
                    const PopupMenuItem(
                      child: Text("Whatsapp Web"),
                      value: "Whatsapp Web",
                    ),
                    const PopupMenuItem(
                      child: Text("Search"),
                      value: "Search",
                    ),
                    const PopupMenuItem(
                      child: Text("Mute Notifications "),
                      value: "Mute Notifications",
                    ),
                    const PopupMenuItem(
                      child: Text("Wallpaper "),
                      value: "Wallpaper",
                    ),
                  ];
                },
              )
            ],
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: WillPopScope(
              onWillPop: () {
                if (show) {
                  setState(() {
                    show = false;
                  });
                } else {
                  Navigator.pop(context);
                }
                return Future.value(false);
              },
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height - 140,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          if (messages[index].type == "source") {
                            return OwnMessage(
                              message: messages[index].message,
                            );
                          } else {
                            return ReplyCard(message: messages[index].message);
                          }
                        }),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width - 55,
                                child: Card(
                                    margin: EdgeInsets.only(
                                        left: 2, right: 2, bottom: 8),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    child: TextFormField(
                                      focusNode: focusNode,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: 5,
                                      minLines: 1,
                                      onChanged: (value) {
                                        if (value.length > 0) {
                                          setState(() {
                                            sendButton = true;
                                          });
                                        } else {
                                          setState(() {
                                            sendButton = false;
                                          });
                                        }
                                      },
                                      controller: _controller,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "type a message",
                                          contentPadding: EdgeInsets.all(5),
                                          prefixIcon: IconButton(
                                            icon: Icon(Icons.emoji_emotions),
                                            onPressed: () {
                                              focusNode.unfocus();
                                              focusNode.canRequestFocus = false;
                                              setState(() {
                                                show = !show;
                                              });
                                            },
                                          ),
                                          suffixIcon: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    showModalBottomSheet(
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        context: context,
                                                        builder: (builder) =>
                                                            bottomsheet());
                                                  },
                                                  icon:
                                                      Icon(Icons.attach_file)),
                                              IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(Icons.camera_alt))
                                            ],
                                          )),
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: 8, right: 2, left: 2),
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor:
                                      Color.fromARGB(210, 165, 171, 214),
                                  child: IconButton(
                                    icon: Icon(
                                        sendButton ? Icons.send : Icons.mic),
                                    onPressed: () {
                                      if (sendButton) {
                                        sendMessage(
                                            _controller.text,
                                            widget.sourceChat!.id!,
                                            widget.chatModel!.id!);
                                        _controller.clear();
                                      }
                                    },
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                          show ? emojiSelect() : Container()
                        ]),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget bottomsheet() {
    return Container(
      height: 270,
      width: MediaQuery.of(context).size.width,
      child: Card(
          margin: EdgeInsets.all(16),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(
                      Icons.insert_drive_file, Colors.indigo, "Document "),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.camera, Colors.pink, "Camera "),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.insert_photo, Colors.purple, "Gallery"),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(Icons.headset, Colors.orange, "Audio "),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.location_pin, Colors.yellow, "Location"),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.person, Colors.blue, "Contact"),
                ],
              )
            ]),
          )),
    );
  }

  Widget iconCreation(IconData icon, Color color, String text) {
    return InkWell(
        onTap: () {},
        child: Column(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: color,
              child: Icon(
                icon,
                size: 29,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              text,
              style: TextStyle(fontSize: 12),
            ),
          ],
        ));
  }

  Widget emojiSelect() {
    return EmojiPicker2(
        rows: 4,
        columns: 7,
        onEmojiSelected: (emoji, category) {
          print(emoji);
          setState(() {
            _controller.text = _controller.text + emoji.emoji;
          });
        });
  }
}
//flutter run --no-sound-null-safety
//Flutter: Let's implement one to one chat functionality (Pt-2) using Socket IO || WhatsApp Clone #20
