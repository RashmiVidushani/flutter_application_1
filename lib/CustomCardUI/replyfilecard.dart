import 'dart:io';

import 'package:flutter/material.dart';

class ReplyFileCard extends StatelessWidget {
  const ReplyFileCard({Key? key, required this.path, this.message, this.time})
      : super(key: key);
  final String path;
  final String? message;
  final String? time;
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Container(
                height: MediaQuery.of(context).size.height / 2.3,
                width: MediaQuery.of(context).size.width / 1.8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey[400]),
                child: Card(
                    margin: EdgeInsets.all(3),
                    color: Color.fromARGB(255, 204, 219, 218),
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Image.network(
                            "http://192.168.8.228:5000/uploads/$path",
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        message!.length > 0
                            ? Container(
                                height: 40,
                                padding: EdgeInsets.only(left: 15, top: 8),
                                child: Text(
                                  message!,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 19, 18, 18),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ))
                            : Container()
                      ],
                    )))));
  }
}
