import 'package:flutter/material.dart';
import 'package:flutter_application_1/CustomCardUI/avatarcard.dart';
import 'package:flutter_application_1/CustomCardUI/buttoncard.dart';
import 'package:flutter_application_1/CustomCardUI/contactcard.dart';
import 'package:flutter_application_1/Model/chatmodel.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({
    Key? key,
  }) : super(key: key);

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  List<ChatModel> contacts = [
    ChatModel(name: "Dev", status: "full stack developer"),
    ChatModel(name: "kir", status: "full stack developer"),
    ChatModel(name: "sdd", status: "full stack developer"),
    ChatModel(name: "De", status: "full stack developer"),
    ChatModel(name: "ki", status: "full stack developer"),
    ChatModel(name: "sd", status: "full stack developer"),
    ChatModel(name: "Dv", status: "full stack developer"),
    ChatModel(name: "ir", status: "full stack developer"),
    ChatModel(name: "dd", status: "full stack developer"),
  ];
  List<ChatModel> groups = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Create New Group",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
              Text(
                "Add participants",
                style: TextStyle(fontSize: 13),
              )
            ],
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  size: 26,
                )),
          ],
        ),
        body: Stack(
          children: [
            ListView.builder(
                itemCount: contacts.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Container(
                      height: groups.length > 0 ? 90 : 10,
                    );
                  }
                  return InkWell(
                    onTap: () {
                      if (contacts[index - 1].select == false) {
                        setState(() {
                          contacts[index - 1].select = true;
                          groups.add(contacts[index - 1]);
                        });
                      } else {
                        setState(() {
                          contacts[index - 1].select = false;
                          groups.remove(contacts[index - 1]);
                        });
                      }
                    },
                    child: ContactCard(
                      contact: contacts[index - 1],
                    ),
                  );
                }),
            groups.length > 0
                ? Column(
                    children: [
                      Column(
                        children: [
                          Container(
                              height: 75,
                              color: Colors.white,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: contacts.length,
                                  itemBuilder: (context, index) {
                                    if (contacts[index].select == true) {
                                      return InkWell(
                                          onTap: () {
                                            setState(() {
                                              groups.remove(contacts[index]);
                                              contacts[index].select = false;
                                            });
                                          },
                                          child: AvatarCard(
                                            contact: contacts[index],
                                          ));
                                    } else {
                                      return Container();
                                    }
                                  })),
                          Divider(
                            thickness: 1,
                          )
                        ],
                      )
                    ],
                  )
                : Container(),
          ],
        ));
  }
}
