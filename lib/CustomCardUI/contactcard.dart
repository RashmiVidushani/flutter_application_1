import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/chatmodel.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({Key? key, this.contact}) : super(key: key);
  final ChatModel? contact;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 53,
        width: 50,
        child: Stack(
          children: [
            CircleAvatar(
              radius: 23,
              child: SvgPicture.asset(
                "assets/groups_black_24dp.svg",
                color: Colors.white,
                height: 30,
                width: 30,
              ),
              backgroundColor: Colors.blueGrey[200],
            ),
            contact!.select
                ? Positioned(
                    bottom: 4,
                    right: 5,
                    child: CircleAvatar(
                        backgroundColor: Colors.teal,
                        radius: 11,
                        child:
                            Icon(Icons.check, color: Colors.white, size: 18)))
                : Container()
          ],
        ),
      ),
      title: Text(
        contact!.name!,
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        contact!.status!,
        style: TextStyle(fontSize: 13),
      ),
    );
  }
}

//Flutter Chat App- Working on Select Contact page || WhatsApp Clone #11
