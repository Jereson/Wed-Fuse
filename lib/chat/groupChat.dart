import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GroupChat {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create a new group chat and add the current user as a member
  Future<String> createGroupChat(String groupName) async {
    final currentUser = _auth.currentUser;
    final newChatRef = _firestore.collection('chats').doc();
    final newChatId = newChatRef.id;
    final newChat = {
      'name': groupName,
      'members': [currentUser?.uid],
      'createdAt': FieldValue.serverTimestamp(),
    };
    await newChatRef.set(newChat);
    return newChatId;
  }

  // Add a user to an existing group chat
  Future<void> addUserToGroupChat(String chatId, String userId) async {
    final chatRef = _firestore.collection('chats').doc(chatId);
    await chatRef.update({
      'members': FieldValue.arrayUnion([userId]),
    });
  }

  // Send a message to a group chat
  Future<void> sendMessage(String chatId, String message) async {
    final currentUser = _auth.currentUser;
    final newMessageRef = _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .doc();
    final newMessage = {
      'senderId': currentUser?.uid,
      'text': message,
      'createdAt': FieldValue.serverTimestamp(),
    };
    await newMessageRef.set(newMessage);
  }

  // Get the messages for a group chat
  Stream<QuerySnapshot<Map<String, dynamic>>> getChatMessages(String chatId) {
    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('createdAt')
        .snapshots();
  }

  // Get the group chats for a user
  Stream<QuerySnapshot<Map<String, dynamic>>> getUserChats() {
    final currentUser = _auth.currentUser;
    return _firestore
        .collection('chats')
        .where('members', arrayContains: currentUser?.uid)
        .snapshots();
  }
}










class GroupChatScreen extends StatefulWidget {
  const GroupChatScreen({super.key});

  @override
  GroupChatScreenState createState() => GroupChatScreenState();
}

class GroupChatScreenState extends State<GroupChatScreen> {
  final TextEditingController _textEditingController =
  TextEditingController();
  final GroupChat _groupChat = GroupChat();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late String _currentChatId;

  @override
  void initState() {
    super.initState();
    _groupChat.getUserChats().listen((QuerySnapshot snapshot) {
      if (snapshot.docs.isNotEmpty) {
        // Select the first chat in the list by default
        setState(() {
          _currentChatId = snapshot.docs[0].id;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Group Chat'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              const userIdToAdd = 'user_id_here';
              await _groupChat.addUserToGroupChat(_currentChatId, userIdToAdd);            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _groupChat.getUserChats(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  final chats = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: chats.length,
                    itemBuilder: (BuildContext context, int index) {
                      final chat = chats[index];
                      return ListTile(
                        title: Text(chat['name']),
                        selected: chat.id == _currentChatId,
                        onTap: () {
                          setState(() {
                            _currentChatId = chat.id;
                          });
                        },
                      );
                    },
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          const Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextField(
                      controller: _textEditingController,
                      decoration: const InputDecoration.collapsed(
                          hintText: 'Enter a message'),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () async {
                    final text = _textEditingController.text.trim();
                    if (text.isNotEmpty) {
                      await _groupChat.sendMessage(_currentChatId, text);
                      _textEditingController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final groupName = 'New Group Chat';
          final chatId = await _groupChat.createGroupChat(groupName);
          setState(() {
            _currentChatId = chatId;
          });
        },
      ),
    );
  }
}
