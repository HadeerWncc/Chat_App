import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  ChatBubble({
    required this.message,
    Key? key,
  }) : super(key: key);
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          color: kPrimaryKey,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(20),
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Text(
          message.message,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class ChatBubbleForAnotherUser extends StatelessWidget {
  ChatBubbleForAnotherUser({
    required this.message,
    Key? key,
  }) : super(key: key);
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          color: Color(0xff006385),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Text(
          message.message,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

