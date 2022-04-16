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
  void initState() {
    super.initState();
    _askPermissions(null!);
  }

  Future<void> _askPermissions(String routeName) async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      if (routeName != null) {
        Navigator.of(context).pushNamed(routeName);
      }
    } else {
      _handleInvalidPermissions(permissionStatus);
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      final snackBar = SnackBar(content: Text('Access to contact data denied'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      final snackBar =
          SnackBar(content: Text('Contact data not available on device'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<ChatModel> contacts = [
      /* ChatModel(name: "Dev", status: "full stack developer"),
      ChatModel(name: "kir", status: "full stack developer"),
      ChatModel(name: "sdd", status: "full stack developer"),
      ChatModel(name: "De", status: "full stack developer"),
      ChatModel(name: "ki", status: "full stack developer"),
      ChatModel(name: "sd", status: "full stack developer"),
      ChatModel(name: "Dv", status: "full stack developer"),
      ChatModel(name: "ir", status: "full stack developer"),
      ChatModel(name: "dd", status: "full stack developer"),*/
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
//15.11