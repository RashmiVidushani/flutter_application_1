import 'package:flutter/material.dart';
import 'package:flutter_application_1/CustomCardUI/buttoncard.dart';
import 'package:flutter_application_1/CustomCardUI/contactcard.dart';
import 'package:flutter_application_1/Model/chatmodel.dart';
import 'package:flutter_application_1/Screens/creategroup.dart';
import 'package:permission_handler/permission_handler.dart';

class SelectContact extends StatefulWidget {
  const SelectContact({
    Key? key,
  }) : super(key: key);

  @override
  State<SelectContact> createState() => _SelectContactState();
}

class _SelectContactState extends State<SelectContact> {
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    List<ChatModel> contacts = [
      ChatModel(name: "Ann", status: "sgdadsfgda"),
      ChatModel(name: "Jack", status: "sgd"),
      ChatModel(name: "Dean", status: "sdgsdf"),
      ChatModel(name: "Sam", status: "sfdfsff"),
      ChatModel(name: "Bobby", status: "xcbxcbxb"),
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
          ],
        ),
        body: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    controller: _scrollController,
                    shrinkWrap: true,
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
                            child: ButtonCard(
                                icon: Icons.group, name: "New group"));
                      } else if (index == 1) {
                        return ButtonCard(
                            icon: Icons.person, name: "New person");
                      }
                      return ContactCard(
                        contact: contacts[index - 2],
                      );
                    }))
          ],
        ));
  }
}
