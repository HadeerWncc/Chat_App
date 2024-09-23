import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/pages/cubites/chat_cubit/chat_cubit.dart';
import 'package:chat_app/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});

  static String id = "chatPage";
  TextEditingController controller = TextEditingController();

  final _controller = ScrollController();
  List<Message> messagesList = [];
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kPrimaryKey,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                klogo,
                height: 50,
              ),
              const Text(
                'chat',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocConsumer<ChatCubit, ChatState>(
                builder: (context, state) {
                  return ListView.builder(
                      reverse: true,
                      controller: _controller,
                      itemCount: messagesList.length,
                      itemBuilder: (context, index) {
                        return messagesList[index].id == email
                            ? ChatBubble(message: messagesList[index])
                            : ChatBubbleForAnotherUser(
                                message: messagesList[index]);
                      });
                },
                listener: (BuildContext context, ChatState state) {
                  if (state is ChatSuccess) {
                    messagesList = state.messages;
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: controller,
                onSubmitted: (value) {
                  BlocProvider.of<ChatCubit>(context)
                      .sendMsg(msg: value, email: email.toString());
                  // messages.add({
                  //   kMessage: value,
                  //   kCreatedAt: DateTime.now(),
                  //   'id': email,
                  // });
                  controller.clear();
                  _controller.animateTo(0, //0 means the begining of the list
                      duration: const Duration(seconds: 1),
                      curve: Curves.fastOutSlowIn);
                },
                decoration: InputDecoration(
                  hintText: "Write message",
                  suffixIcon: const Icon(
                    Icons.send,
                    color: kPrimaryKey,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: kPrimaryKey,
                      )),
                ),
              ),
            )
          ],
        )

        //
        );
  }
}
