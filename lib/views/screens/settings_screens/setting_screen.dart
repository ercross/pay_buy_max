
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pay_buy_max/controllers/providers/coin_price_provider.dart';
import 'package:pay_buy_max/models/auth/sign_in_response_entity.dart';
import 'package:pay_buy_max/models/auth/sign_up_response_entity.dart';
import 'package:pay_buy_max/views/widgets/overlays.dart';
import 'package:provider/provider.dart';
import '../../../style_sheet.dart';
import 'package:http/http.dart' as http;


class SettingScreen extends StatelessWidget {
  const SettingScreen();

  static const String route = "/settingScreen";

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CoinPriceProvider>(
            create: (context) => CoinPriceProvider()),
      ],
      child: const SettingScreenWidget(),
    );
  }

}

class SettingScreenWidget extends StatefulWidget {
  const SettingScreenWidget();

  @override
  _SettingScreenWidgetState createState() => _SettingScreenWidgetState();
}

class _SettingScreenWidgetState extends State<SettingScreenWidget> {
  late TextEditingController textController;
  late TextEditingController oldController;
  late TextEditingController newController;
  late TextEditingController confirmController;
  late TextEditingController emailController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String value = "International Passport";
  late SignInResponseEntity args;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    oldController = TextEditingController();
    newController = TextEditingController();
    confirmController = TextEditingController();
    emailController = TextEditingController.fromValue(TextEditingValue(text: "cephasarowolo@gmail.com"));
  }

  void _changePassword(){
    if(oldController.text.isEmpty){
      AppOverlay.snackbar(message: "Fields Cannot Be Empty");
    }else if(newController.text.isEmpty){
      AppOverlay.snackbar(message: "Fields Cannot Be Empty");
    }else if(confirmController.text.isEmpty){
      AppOverlay.snackbar(message: "Fields Cannot Be Empty");
    }else{
      if(newController.text == confirmController.text){
        changePassword().then((value){
          setState(() {
            if(value.status == true){
              AppOverlay.snackbar(message: "Success");
            }else{
              if(value.message == null){
                AppOverlay.snackbar(message: "An Error Occurred");
              }else{
                AppOverlay.snackbar(message: value.message.toString());
              }
            }
          });
        });
      }else{
        AppOverlay.snackbar(message: "Fields Do Not Match");
      }
    }
  }

  Future<SignUpResponseEntity> changePassword() async{
    String url = 'https://paybuymax.com/api/update-password';
    print(args.token.toString());
    final response = await http.patch(Uri.parse(url),headers: {"Authorization":args.token.toString()},body: {"oldPassword":oldController.text,"password":newController.text,"confirmPassword":confirmController.text});
    return SignUpResponseEntity().fromJson(json.decode(response.body));
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)!.settings.arguments as SignInResponseEntity;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: StyleSheet.primaryColor.withOpacity(0.09),
      body: SafeArea(
        child: Expanded(
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Container(
                height:400,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 6,
                    color: Color(0xFFFAFAFA),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left:15,right:15,bottom: 15,top: 10),
                          child:  Text('Profile', style: TextStyle(color: Colors.black54, fontSize: 20,fontWeight: FontWeight.bold), textAlign: TextAlign.start),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:15,right:15,bottom: 2,top: 10),
                          child:  Text('Name', style: TextStyle(color: Colors.black54, fontSize: 14), textAlign: TextAlign.start),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15,right: 15,bottom: 7),
                            child: TextFormField(
                              controller: textController,
                              obscureText: false,
                              decoration: const InputDecoration(border: OutlineInputBorder()),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:15,right:15,bottom: 2,top: 10),
                          child:  Text('Email', style: TextStyle(color: Colors.black54, fontSize: 14), textAlign: TextAlign.start),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15,right: 15),
                            child: TextFormField(
                              controller: emailController,
                              obscureText: false,
                              readOnly: true,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                filled: true,
                                contentPadding:
                                EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:15,right:15,bottom: 2,top: 10),
                          child:  Text('Phone', style: TextStyle(color: Colors.black54, fontSize: 14), textAlign: TextAlign.start),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15,right: 15,bottom: 7),
                            child: TextFormField(
                              controller: textController,
                              obscureText: false,
                              decoration: const InputDecoration(border: OutlineInputBorder()),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left:15,right:15,bottom: 10),
                                child: ElevatedButton(onPressed: (){}, child: Text("UPDATE"),style: ElevatedButton.styleFrom(primary:Colors.black)),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height:400,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 6,
                    color: Color(0xFFFAFAFA),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left:15,right:15,bottom: 15,top: 10),
                          child:  Text('Change Password', style: TextStyle(color: Colors.black54, fontSize: 20,fontWeight: FontWeight.bold), textAlign: TextAlign.start),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:15,right:15,bottom: 2,top: 10),
                          child:  Text('Current Password', style: TextStyle(color: Colors.black54, fontSize: 14), textAlign: TextAlign.start),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15,right: 15,bottom: 7),
                            child: TextFormField(
                              controller: oldController,
                              obscureText: false,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: const InputDecoration(border: OutlineInputBorder()),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:15,right:15,bottom: 2,top: 10),
                          child:  Text('New Password', style: TextStyle(color: Colors.black54, fontSize: 14), textAlign: TextAlign.start),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15,right: 15,bottom: 7),
                            child: TextFormField(
                              controller: newController,
                              obscureText: false,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: const InputDecoration(border: OutlineInputBorder()),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:15,right:15,bottom: 2,top: 10),
                          child:  Text('Confirm Password', style: TextStyle(color: Colors.black54, fontSize: 14), textAlign: TextAlign.start),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15,right: 15,bottom: 7),
                            child: TextFormField(
                              controller: confirmController,
                              obscureText: false,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: const InputDecoration(border: OutlineInputBorder()),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left:15,right:15,bottom: 10),
                                child: ElevatedButton(onPressed: (){
                                  _changePassword();
                                }, child: Text("SUBMIT"),style: ElevatedButton.styleFrom(primary:Colors.black)),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height:300,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 6,
                    color: Color(0xFFFAFAFA),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left:15,right:15,bottom: 15,top: 10),
                          child:  Text('Upload Valid Documents', style: TextStyle(color: Colors.black54, fontSize: 20,fontWeight: FontWeight.bold), textAlign: TextAlign.start),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:15,right:15,bottom: 2,top: 10),
                          child:  Text('Select Document', style: TextStyle(color: Colors.black54, fontSize: 14), textAlign: TextAlign.start),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left:15,right:15),
                            child: InputDecorator(
                              decoration: const InputDecoration(border: OutlineInputBorder()),
                              child: DropdownButton(
                                  value: value,
                                  underline: SizedBox.shrink(),
                                  isExpanded: true, items: ["International Passport","Identity Card","Drivers License","Proof Of Residence"].map((String value) {
                                return DropdownMenuItem(value: value,child: Text(value));
                              }).toList(), onChanged: (_value){
                                setState(() {
                                  value = _value as String;
                                });
                              }),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:15,right:15,bottom: 2,top: 10),
                          child:  Text('Choose Document To Upload', style: TextStyle(color: Colors.black54, fontSize: 14), textAlign: TextAlign.start),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15,right: 15,bottom: 7),
                            child: TextFormField(
                              controller: textController,
                              obscureText: false,
                              decoration: const InputDecoration(border: OutlineInputBorder()),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left:15,right:15,bottom: 10),
                                child: ElevatedButton(onPressed: (){}, child: Text("UPLOAD"),style: ElevatedButton.styleFrom(primary:Colors.black)),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
