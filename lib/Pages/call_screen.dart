import 'package:flutter/material.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({Key? key}) : super(key: key);

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        callCard("Dev Stack", Icons.call_made, Colors.green, "july 15th"),
        callCard("Dev1", Icons.call_received, Colors.green, "july 15th"),
        callCard("Dev2", Icons.call_missed, Colors.red, "july 15th"),
        callCard("Dev Stack", Icons.call_made, Colors.green, "july 15th"),
        callCard("Dev1", Icons.call_received, Colors.green, "july 15th"),
        callCard("Dev2", Icons.call_missed, Colors.red, "july 15th"),
        callCard("Dev Stack", Icons.call_made, Colors.green, "july 15th"),
        callCard("Dev1", Icons.call_received, Colors.green, "july 15th"),
        callCard("Dev2", Icons.call_missed, Colors.red, "july 15th"),
        callCard("Dev Stack", Icons.call_made, Colors.green, "july 15th"),
        callCard("Dev1", Icons.call_received, Colors.green, "july 15th"),
        callCard("Dev2", Icons.call_missed, Colors.red, "july 15th"),
      ]),
    );
  }

  Widget callCard(
      String name, IconData icondata, Color iconColor, String time) {
    return Card(
        margin: EdgeInsets.only(bottom: 0.5),
        child: ListTile(
          leading: CircleAvatar(
            radius: 26,
          ),
          title: Text(
            name,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
          ),
          subtitle: Row(
            children: [
              Icon(
                icondata,
                color: iconColor,
                size: 20,
              ),
              SizedBox(
                width: 6,
              ),
              Text(time, style: TextStyle(fontSize: 13))
            ],
          ),
          trailing: Icon(
            Icons.call,
            size: 28,
            color: Colors.teal,
          ),
        ));
  }
}
