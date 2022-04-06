import 'package:flutter/material.dart';
import 'package:flutter_application_1/CustomCardUI/StatusUI/headown.dart';
import 'package:flutter_application_1/CustomCardUI/StatusUI/othersstatus.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 48,
            child: FloatingActionButton(
                backgroundColor: Colors.blueGrey[100],
                elevation: 8,
                onPressed: () {},
                child: Icon(
                  Icons.edit,
                  color: Color.fromARGB(255, 160, 148, 106),
                )),
          ),
          SizedBox(
            height: 13,
          ),
          FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.greenAccent[700],
            elevation: 5,
            child: Icon(Icons.camera),
          )
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          HeadOwn(),
          Container(
            height: 33,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey[300],
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 13, vertical: 7),
              child: Text("Recent Updates",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
            ),
          ),
          OthersStatus(
            name: "test 2",
            imageName: "assets/s2.jpg",
            time: "02:34",
            isSeen: false,
            statusNum: 1,
          ),
          OthersStatus(
            name: "test 1",
            imageName: "assets/s3.jpeg",
            time: "00:34",
            isSeen: false,
            statusNum: 2,
          ),
          OthersStatus(
            name: "test 3",
            imageName: "assets/s4.jpg",
            time: "12:34",
            isSeen: true,
            statusNum: 3,
          ),
          SizedBox(
            height: 10,
          ),
          label("Viewed Updates"),
          OthersStatus(
            name: "test 4",
            imageName: "assets/s5.jpg",
            time: "02:34",
            isSeen: false,
            statusNum: 4,
          ),
          OthersStatus(
            name: "test 5",
            imageName: "assets/s6.jpg",
            time: "00:34",
            isSeen: true,
            statusNum: 5,
          ),
          OthersStatus(
            name: "test 6",
            imageName: "assets/s1.jpg",
            time: "12:34",
            isSeen: true,
            statusNum: 6,
          ),
        ],
      )),
    );
  }

  Widget label(String labelName) {
    return Container(
      height: 33,
      width: MediaQuery.of(context).size.width,
      color: Colors.grey[300],
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 13, vertical: 7),
        child: Text(labelName,
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
//Flutter - Working on Status Page of Whatsapp Clone || Speed Code || #23