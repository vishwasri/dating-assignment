import 'dart:convert';
import 'package:dating/models/User.dart';
import 'package:dating/screens/widgets/user_card.dart';
import 'package:dating/utils/text_styles.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:swipe_cards/swipe_cards.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  final databaseReference = FirebaseDatabase.instance.ref();
  List<SwipeItem> swipeItems = [];
  MatchEngine? matchEngine;
  bool noMoreCards = false;

  void listenFirebaseData(){
    databaseReference.onValue.listen((event) {
      updateUI(event.snapshot);
    });
  }

  void updateUI(DataSnapshot dataSnapshot){
    swipeItems.clear();
    setState(() {
      dataSnapshot.child("data").children.forEach((element) {
        User user = userFromJson(jsonEncode(element.value));
        swipeItems.add(SwipeItem(content: user));
      });
      matchEngine = MatchEngine(swipeItems: swipeItems);
    });
  }

  @override
  void initState() {
    listenFirebaseData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    if(swipeItems.isEmpty){
      return const Center(child: CircularProgressIndicator(),);
    } else if(noMoreCards){
      return  const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("추천 드릴 친구들을 준비 중이에요",style: txtSubHeader,),
            Text("매일 새로운 친구들을 소개시켜드려요",style: txtParagraph,),
          ],
        ),
      );
    } else {
      return SwipeCards(
        matchEngine: matchEngine!,
        onStackFinished: (){
          setState(() {
            noMoreCards = true;
          });
        },
        itemBuilder: (BuildContext context, int index) {
          return UserCard(swipeItems[index].content);
        },
      );
    }
  }
}
