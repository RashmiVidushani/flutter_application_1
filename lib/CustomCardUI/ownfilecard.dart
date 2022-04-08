import 'dart:io';

import 'package:flutter/material.dart';

class OwnFileCard extends StatelessWidget {
  const OwnFileCard({Key? key, this.path, this.message, this.time})
      : super(key: key);
  final String? path;
  final String? message;
  final String? time;
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerRight,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Container(
                height: MediaQuery.of(context).size.height / 2.3,
                width: MediaQuery.of(context).size.width / 1.8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.teal[400]),
                child: Card(
                    margin: EdgeInsets.all(3),
                    color: Colors.teal[400],
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Image.file(
                            File(path!),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        message!.length < 0
                            ? Stack(children: [
                                Text(
                                  message!,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(time!,
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.grey[600])),
                                Icon(
                                  Icons.done_all,
                                  size: 16,
                                )
                              ])
                            : Container()
                      ],
                    )))));
  }
}
