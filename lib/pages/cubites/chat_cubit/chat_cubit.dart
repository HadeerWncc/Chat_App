import 'package:bloc/bloc.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessageCollection);
      
  sendMsg({required String msg, required String email}) {
    messages.add({
      kMessage: msg,
      kCreatedAt: DateTime.now(),
      'id': email,
    });
  }

  getMsgs() {
    messages.orderBy(kCreatedAt, descending: true).snapshots().listen((event) {
  List<Message> messageList = [];

      messageList.clear();
      for (var doc in event.docs) {
        messageList.add(Message.fromjson(doc));
      }
      emit(ChatSuccess(messages: messageList));
    });
  }
}
