import 'package:flutter/material.dart';

class HeadOwn extends StatefulWidget {
  const HeadOwn({Key? key}) : super(key: key);

  @override
  State<HeadOwn> createState() => _HeadOwnState();
}

class _HeadOwnState extends State<HeadOwn> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Stack(children: [
        CircleAvatar(
          radius: 27,
          backgroundColor: Colors.white,
          backgroundImage: AssetImage("assets/s1.jpg"),
        ),
        Positioned(
            bottom: 0,
            right: 0,
            child: CircleAvatar(
              backgroundColor: Colors.greenAccent[700],
              radius: 10,
              child: Icon(
                Icons.add,
                size: 20,
                color: Colors.white,
              ),
            ))
      ]),
      title: Text("My status",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
      subtitle: Text(
        "Tap to add status",
        style: TextStyle(fontSize: 13, color: Colors.grey[900]),
      ),
    );
  }
}
