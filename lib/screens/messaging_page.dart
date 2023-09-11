import 'package:dating/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';

class MessagingPage extends StatefulWidget {
  const MessagingPage({super.key});

  @override
  State<MessagingPage> createState() => _MessagingPageState();
}

class _MessagingPageState extends State<MessagingPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Messaging",style: txtSubHeader,),);
  }
}
