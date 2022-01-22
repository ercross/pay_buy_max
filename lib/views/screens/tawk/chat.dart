
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pay_buy_max/controllers/providers/user_provider.dart';
import 'package:pay_buy_max/views/screens/tawk/tawk_visitor.dart';
import 'package:pay_buy_max/views/screens/tawk/tawk_widget.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatelessWidget {
  const ChatPage();

  static const String route = "/chat";

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
            create: (context) => UserProvider()),
      ],
      child: const _ChatPage(),
    );
  }
}

class _ChatPage extends StatefulWidget {
  const _ChatPage();

  @override
  State<StatefulWidget> createState() => _ChatState();
}

class _ChatState extends State<_ChatPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Chat'),
          backgroundColor: Color(0XFFF7931E),
          elevation: 0,
        ),
        body: Tawk(
          directChatLink: 'YOUR_DIRECT_CHAT_LINK',
          visitor: TawkVisitor(
            name: 'Ayoub AMINE',
            email: 'ayoubamine2a@gmail.com', hash: '',
          ),
          onLoad: () {

          },
          onLinkTap: (String url) {

          },
          placeholder: Center(
            child: Text('Loading...'),
          ),
        ),
      ),
    );
  }
}
