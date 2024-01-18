import 'dart:developer';

import 'package:chatting_application_from_youtube/api/apis.dart';
import 'package:chatting_application_from_youtube/main.dart';
import 'package:chatting_application_from_youtube/widgets/chat_user_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(CupertinoIcons.home),
        title: Text('Our Chat'),
        actions: [
          //Icon for searching the chat
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          //Icon for more features
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),

      //This is the floating button which is used to add a new user.
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: FloatingActionButton(
          onPressed: () async {
            await APIs.auth.signOut();
            await GoogleSignIn().signOut();
          },
          child: Icon(Icons.add_comment_sharp),
        ),
      ),
      body: StreamBuilder(
          stream: APIs.firestore.collection('users').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data?.docs;
              log("Data: ${data}");
            }
            return ListView.builder(
                itemCount: 16,
                padding: EdgeInsets.only(top: mq.height * .01),
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return ChatUserCard();
                });
          }),
    );
  }
}
