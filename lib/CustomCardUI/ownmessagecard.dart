import 'package:flutter/material.dart';

class OwnMessage extends StatelessWidget {
  const OwnMessage({Key? key, this.message}) : super(key: key);
  final String? message;
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerRight,
        child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width - 45,
            ),
            child: Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              color: const Color(0xffdcf8c6),
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 10,
                      right: 30,
                      top: 5,
                      bottom: 20,
                    ),
                    child: Text(
                      message!,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  Positioned(
                      bottom: 4,
                      right: 10,
                      child: Row(
                        children: [
                          Text("12:23",
                              style: TextStyle(
                                  fontSize: 13, color: Colors.grey[600])),
                          Icon(
                            Icons.done_all,
                            size: 16,
                          )
                        ],
                      ))
                ],
              ),
            )));
  }
}
