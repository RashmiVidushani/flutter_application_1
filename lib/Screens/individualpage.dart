import 'dart:convert';
import 'package:emoji_picker_2/emoji_picker_2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/CustomCardUI/ownfilecard.dart';
import 'package:flutter_application_1/CustomCardUI/ownmessagecard.dart';
import 'package:flutter_application_1/CustomCardUI/replycard.dart';
import 'package:flutter_application_1/CustomCardUI/replyfilecard.dart';
import 'package:flutter_application_1/Model/chatmodel.dart';
import 'package:flutter_application_1/Model/chatmodel.dart';
import 'package:flutter_application_1/Model/messagemodel.dart';
import 'package:flutter_application_1/Screens/camarascreen.dart';
import 'package:flutter_application_1/Screens/cameraview.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;

class IndividualPage extends StatefulWidget {
  const IndividualPage({Key? key, this.chatModel, this.sourceChat, this.time})
      : super(key: key);
  final ChatModel? chatModel;
  final ChatModel? sourceChat;
  final String? time;
  @override
  State<IndividualPage> createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  bool show = false;
  FocusNode focusNode = FocusNode();
  TextEditingController _controller = TextEditingController();
  ScrollController _scrollController = ScrollController();
  late IO.Socket socket;
  bool sendButton = false;
  ImagePicker _picker = ImagePicker();
  XFile? file;
  int popTime = 0;
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
    socket.onConnect((data) => print("connected"));
    socket.on("message", (msg) {
      print(msg);
      setMessage(
        "destination",
        msg["message"],
        msg["path"],
      );
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    });

    print(socket.connected);
  }

  void sendMessage(String message, int sourceId, int targetId, String path) {
    setMessage("source", message, path);
    socket.emit("message", {
      "message": message,
      "sourceId": sourceId,
      "targetId": targetId,
      "path": path
    });
  }

  void setMessage(String type, String message, String path) {
    MessageModel messageModel = MessageModel(
        type: type,
        message: message,
        path: path,
        time: DateTime.now().toString().substring(10, 16));
    setState(() {
      setState(() {
        messages.add(messageModel);
      });
    });
  }

  void onImageSend(String path, String message) async {
    print("working $message");
    for (int i = 0; i < popTime; i++) {
      Navigator.pop(context);
    }
    setState(() {
      popTime = 0;
    });

    var request = http.MultipartRequest(
        "POST", Uri.parse("http://192.168.8.228:5000/routes/addimage"));
    request.files.add(await http.MultipartFile.fromPath("img", path));
    request.headers.addAll({
      "Content-type": "multipart/form-data",
    });
    http.StreamedResponse response = await request.send();
    var httpResponse = await http.Response.fromStream(response);
    var data = json.decode(httpResponse.body);
    print(data['path']);
    setMessage("source", message, path);
    socket.emit("message", {
      "message": message,
      "sourceId": widget.sourceChat!.id!,
      "targetId": widget.chatModel!.id!,
      "path": data['path']
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
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        controller: _scrollController,
                        shrinkWrap: true,
                        itemCount: messages.length + 1,
                        itemBuilder: (context, index) {
                          if (index == messages.length) {
                            return Container(
                              height: 70,
                            );
                          }
                          if (messages[index].type == "source") {
                            if (messages[index].path.length > 0) {
                              return OwnFileCard(
                                path: messages[index].path,
                                message: messages[index].message,
                                time: messages[index].time,
                              );
                            } else {
                              return OwnMessage(
                                  message: messages[index].message,
                                  time: messages[index].time);
                            }
                          } else {
                            if (messages[index].path.length > 0) {
                              return ReplyFileCard(
                                path: messages[index].path,
                                message: messages[index].message,
                                time: messages[index].time,
                              );
                            } else {
                              return ReplyCard(
                                  message: messages[index].message,
                                  time: messages[index].time);
                            }
                          }
                        }),
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 70,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width - 55,
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
                                                icon:
                                                    Icon(Icons.emoji_emotions),
                                                onPressed: () {
                                                  focusNode.unfocus();
                                                  focusNode.canRequestFocus =
                                                      false;
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
                                                                Colors
                                                                    .transparent,
                                                            context: context,
                                                            builder: (builder) =>
                                                                bottomsheet());
                                                      },
                                                      icon: Icon(
                                                          Icons.attach_file)),
                                                  IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          popTime = 2;
                                                        });
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (builder) =>
                                                                    CamaraScreen(
                                                                        onImageSend:
                                                                            onImageSend)));
                                                      },
                                                      icon: Icon(
                                                          Icons.camera_alt))
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
                                        icon: Icon(sendButton
                                            ? Icons.send
                                            : Icons.mic),
                                        onPressed: () {
                                          if (sendButton) {
                                            _scrollController.animateTo(
                                                _scrollController
                                                    .position.maxScrollExtent,
                                                duration:
                                                    Duration(milliseconds: 300),
                                                curve: Curves.easeOut);
                                            sendMessage(
                                                _controller.text,
                                                widget.sourceChat!.id!,
                                                widget.chatModel!.id!,
                                                "");
                                            _controller.clear();
                                            setState(() {
                                              sendButton = false;
                                            });
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
                      ))
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
                  iconCreation(Icons.insert_drive_file, Colors.indigo,
                      "Document ", () {}),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.camera, Colors.pink, "Camera ", () {
                    setState(() {
                      popTime = 3;
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => CamaraScreen(
                                  onImageSend: onImageSend,
                                )));
                  }),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.insert_photo, Colors.purple, "Gallery",
                      () async {
                    setState(() {
                      popTime = 2;
                    });
                    file = await _picker.pickImage(source: ImageSource.gallery);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => CameraView(
                                  path: file!.path,
                                  onImageSend: onImageSend,
                                )));
                  }),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(Icons.headset, Colors.orange, "Audio ", () {}),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(
                      Icons.location_pin, Colors.yellow, "Location", () {}),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.person, Colors.blue, "Contact", () {}),
                ],
              )
            ]),
          )),
    );
  }

  Widget iconCreation(
      IconData icon, Color color, String text, VoidCallback onTap) {
    return InkWell(
        onTap: onTap,
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

//Flutter - Let's Share one to one Images on our chat app (part -4) || ChatApp #33
