import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:globalchat/providers/user_provider.dart';
import 'package:provider/provider.dart';

class ChatroomPage extends StatefulWidget {
  final String chatroomName;
  final String chatroomId;
  const ChatroomPage({
    super.key,
    required this.chatroomName,
    required this.chatroomId,
  });

  @override
  State<ChatroomPage> createState() => _ChatroomPageState();
}

class _ChatroomPageState extends State<ChatroomPage> {
  var db = FirebaseFirestore.instance;

  TextEditingController messageController = TextEditingController();
  Future<void> sendMessage() async {
    if (messageController.text.isEmpty) {
      return;
    }

    Map<String, dynamic> messageData = {
      "text": messageController.text,
      "sender_name": Provider.of<UserProvider>(context, listen: false).userName,
      "sender_id": Provider.of<UserProvider>(context, listen: false).userId,
      "chatroom_id": widget.chatroomId,
      "timestamp": FieldValue.serverTimestamp(),
    };

    try {
      await db.collection("chat_messages").add(messageData);
    } catch (e) {
      print("Error sending message: $e");
    }

    messageController.clear();
  }

  Widget singlechatItem({
    required String senderName,
    required String text,
    required String senderId,
    required bool isCurrentUser,
  }) {
    return Align(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: isCurrentUser
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          if (!isCurrentUser)
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
              child: Text(
                senderName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.grey[700],
                ),
              ),
            ),
          Container(
            constraints: BoxConstraints(maxWidth: 250),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: isCurrentUser ? Colors.purple : Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              text,
              style: TextStyle(
                color: isCurrentUser ? Colors.white : Colors.black,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.chatroomName)),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: db
                  .collection("chat_messages")
                  .where("chatroom_id", isEqualTo: widget.chatroomId)
                  .limit(10)
                  .orderBy("timestamp", descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print("Error fetching messages: ${snapshot.error}");
                  return Center(child: Text("Error loading messages"));
                }
                var allMessages = snapshot.data?.docs ?? [];

                return ListView.builder(
                  reverse: true,
                  itemCount: allMessages.length,
                  itemBuilder: (BuildContext context, int index) {
                    var currentUserId = Provider.of<UserProvider>(
                      context,
                      listen: false,
                    ).userId;
                    var isCurrentUser =
                        allMessages[index]["sender_id"] == currentUserId;

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 8.0,
                      ),
                      child: singlechatItem(
                        senderName: allMessages[index]["sender_name"] ?? "",
                        text: allMessages[index]["text"] ?? "",
                        senderId: allMessages[index]["sender_id"] ?? "",
                        isCurrentUser: isCurrentUser,
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 5,
                  offset: Offset(0, -1),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 8.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.purple, width: 2),
                      ),
                      hintText: "Type message...",
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: sendMessage,
                    icon: Icon(Icons.send, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
