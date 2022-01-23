

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pay_buy_max/controllers/providers/user_provider.dart';
import 'package:pay_buy_max/models/auth/sign_in_response_entity.dart';
import 'package:pay_buy_max/views/screens/tawk/tawk_visitor.dart';
import 'package:pay_buy_max/views/screens/tawk/tawk_widget.dart';
import 'package:provider/provider.dart';
import '../../../style_sheet.dart';


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
  late SignInResponseEntity args;

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)!.settings.arguments as SignInResponseEntity;

    var name = args.user!.email.toString();
    if(args.user!.name != null){
      name = args.user!.name.toString();
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark,
              systemNavigationBarColor: StyleSheet.primaryColor
                  .withOpacity(0.09)),
          centerTitle: true,
          backgroundColor: Color(0xFFC9782F),
          title: Text("Chat", style: TextStyle(color: Color(0xFFFAFAFA), fontSize: 18), textAlign: TextAlign.start),
          leading: IconButton(icon: new Icon(Icons.arrow_back_rounded), onPressed: () {Navigator.of(context).pop();}, color: Color(0xFFFAFAFA)),
        ),
        body: Tawk(
          directChatLink: 'https://tawk.to/chat/611bde74d6e7610a49b0a01e/1fdadpu1t',
          visitor: TawkVisitor(
            name: name,
            email: args.user!.email.toString(), hash: '',
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
