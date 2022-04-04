import 'package:flutter/material.dart';
import 'package:flutter_application_1/CustomCardUI/buttoncard.dart';
import 'package:flutter_application_1/CustomCardUI/contactcard.dart';
import 'package:flutter_application_1/Model/chatmodel.dart';
import 'package:flutter_application_1/Screens/creategroup.dart';

class SelectContact extends StatefulWidget {
  const SelectContact({
    Key? key,
  }) : super(key: key);

  @override
  State<SelectContact> createState() => _SelectContactState();
}

class _SelectContactState extends State<SelectContact> {
  @override
  Widget build(BuildContext context) {
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
    return Scaffold(
        appBar: AppBar(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("SelectContact",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
              Text(
                "256 contacts",
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
            PopupMenuButton<String>(
              onSelected: (value) {
                print(value);
              },
              itemBuilder: (BuildContext contesxt) {
                return [
                  const PopupMenuItem(
                    child: Text("Invite a friend"),
                    value: "Invite a friend",
                  ),
                  const PopupMenuItem(
                    child: Text("Contacts"),
                    value: "Contacts",
                  ),
                  const PopupMenuItem(
                    child: Text("Refresh"),
                    value: "Refresh",
                  ),
                  const PopupMenuItem(
                    child: Text("Help"),
                    value: "Help",
                  ),
                ];
              },
            )
          ],
        ),
        body: ListView.builder(
            itemCount: contacts.length + 2,
            itemBuilder: (context, index) {
              if (index == 0) {
                return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => CreateGroup()));
                    },
                    child: ButtonCard(icon: Icons.group, name: "New group"));
              } else if (index == 1) {
                return ButtonCard(icon: Icons.person, name: "New person");
              }
              return ContactCard(
                contact: contacts[index - 2],
              );
            }));
  }
}
//15.11