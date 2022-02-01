
import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pay_buy_max/controllers/providers/coin_price_provider.dart';
import 'package:pay_buy_max/models/auth/sign_in_response_entity.dart';
import 'package:pay_buy_max/models/auth/sign_up_response_entity.dart';
import 'package:pay_buy_max/models/upload_response_entity.dart';
import 'package:pay_buy_max/views/widgets/overlays.dart';
import 'package:provider/provider.dart';
import '../../../style_sheet.dart';
import 'package:http/http.dart' as http;
import 'package:cloudinary_public/cloudinary_public.dart';

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
  late TextEditingController phoneController;
  late TextEditingController oldController;
  late TextEditingController newController;
  late TextEditingController confirmController;
  late TextEditingController emailController;
  late TextEditingController fileController;
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
    emailController = TextEditingController();
    phoneController = TextEditingController();
    fileController = TextEditingController(text: "Choose File");
  }

  void _changePassword(BuildContext context){
    if(oldController.text.isEmpty){
      AppOverlay.snackbar(message: "Fields Cannot Be Empty",title:"Error");
    }else if(newController.text.isEmpty){
      AppOverlay.snackbar(message: "Fields Cannot Be Empty",title:"Error");
    }else if(confirmController.text.isEmpty){
      AppOverlay.snackbar(message: "Fields Cannot Be Empty",title:"Error");
    }else{
      if(newController.text == confirmController.text){
        showLoadingDialog(context,"Changing Password, Please Wait");
        changePassword().then((value){
          Navigator.pop(context);
          setState(() {
            if(value.status == true){
              AppOverlay.snackbar(message: "Success",title:"Success");
            }else{
              if(value.message == null){
                AppOverlay.snackbar(message: "An Error Occurred",title:"Error");
              }else{
                AppOverlay.snackbar(message: value.message.toString());
              }
            }
          });
        });
      }else{
        AppOverlay.snackbar(message: "Fields Do Not Match",title:"Error");
      }
    }
  }

  Future<SignUpResponseEntity> changePassword() async{
    String url = 'https://paybuymax.com/api/update-password';
    final response = await http.patch(Uri.parse(url),headers: {"Authorization":args.token.toString()},body: {"oldPassword":oldController.text,"password":newController.text,"confirmPassword":confirmController.text});
    return SignUpResponseEntity().fromJson(json.decode(response.body));
  }

  void _changeProfile(BuildContext context){
    if(phoneController.text.isEmpty){
      AppOverlay.snackbar(message: "Fields Cannot Be Empty",title:"Error");
    }else if(textController.text.isEmpty){
      AppOverlay.snackbar(message: "Fields Cannot Be Empty",title:"Error");
    }else{
      showLoadingDialog(context,"Updating Profile, Please Wait");
      changeProfile().then((value){
        Navigator.pop(context);
        setState(() {
          if(value.status == true){
            if(value.message == null){
              AppOverlay.snackbar(message: "Success",title:"Success");
            }else{
              AppOverlay.snackbar(message: value.message.toString(),title:"Success");
            }
          }else{
            if(value.message == null){
              AppOverlay.snackbar(message: "An Error Occurred",title:"Error");
            }else{
              AppOverlay.snackbar(message: value.message.toString(),title:"Error");
            }
          }
        });
      });
    }
  }

  Future<SignUpResponseEntity> changeProfile() async{
    String url = 'https://paybuymax.com/api/update/profile';
    final response = await http.patch(Uri.parse(url),headers: {"Authorization":args.token.toString()},body: {"phone":phoneController.text,"name":textController.text});
    return SignUpResponseEntity().fromJson(json.decode(response.body));
  }

  FilePickerResult? pickedFile;
  void _pickFile(){
    pickFile().then((value){
      if(value!=null){
        pickedFile = value;
        fileController.text = value.names.single.toString();
      }
    });
  }

  Future<FilePickerResult?> pickFile() async{
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      //File file = File(result.files.single.path.toString());
      return result;
    } else {
      return null;
    }
  }

  void _uploadFile(BuildContext context){
    if(pickedFile == null){
      AppOverlay.snackbar(message: "Pick A File",title:"Error");
    }else{
      showLoadingDialog(context, "Uploading File. Please Wait");
      uploadFile().then((value){
        Navigator.pop(context);
        if(value!=null){
          if(value.status == true){
            AppOverlay.snackbar(message: value.message.toString(),title:"Success");
          }else{
            AppOverlay.snackbar(message: "Upload Successful",title:"Success");
          }
        }else{
          AppOverlay.snackbar(message: "Upload Failed",title:"Error");
        }
      });
    }
  }

  Future<UploadResponseEntity?> uploadFile() async{
    if(pickedFile!=null){
      try{
        final cloudinary = CloudinaryPublic('paybuymax-com', 'en3jr1t4', cache: false);

        final res = await cloudinary.uploadFile(
            CloudinaryFile.fromFile(
              pickedFile!.paths.first.toString(),
              folder: 'KYC',
              context: {
                'file_name': pickedFile!.names.single.toString(),
                'caption': value,
              },
            )
        );

        String url = 'https://paybuymax.com/api/upload/kyc';
        final response = await http.patch(Uri.parse(url),headers: {"Authorization":args.token.toString()},body: {"imageUrl":res.url,"document":value});
        return UploadResponseEntity().fromJson(json.decode(response.body));
      }catch(e, stacktrace){
        print(stacktrace.toString());
        var error = UploadResponseEntity();
        error.status = false;
        error.message = "Upload Failed";
        return error;
      }
    }
  }

  void showLoadingDialog(BuildContext context,String text){
    AlertDialog alertDialog = AlertDialog(
      content: Row(
        children: [
          CircularProgressIndicator(),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Text(text),
          )
        ],
      ),
    );

    showDialog(barrierDismissible: false, context:context, builder: (BuildContext context){
      return alertDialog;
    });
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)!.settings.arguments as SignInResponseEntity;
    emailController.text = args.user!.email.toString();
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: StyleSheet.primaryColor.withOpacity(0.09),
      body: SafeArea(
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
                            controller: phoneController,
                            obscureText: false,
                            decoration: const InputDecoration(border: OutlineInputBorder()),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left:15,right:15,bottom: 10),
                              child: ElevatedButton(onPressed: (){
                                _changeProfile(context);
                              }, child: Text("UPDATE"),style: ElevatedButton.styleFrom(primary:Colors.black)),
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
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left:15,right:15,bottom: 10),
                              child: ElevatedButton(onPressed: (){
                                _changePassword(context);
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
              height:310,
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
                          padding: const EdgeInsets.only(left: 15,right: 15),
                          child: TextFormField(
                            controller: fileController,
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
                            onTap: (){
                              _pickFile();
                              print("print");
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left:15,right:15,bottom: 10),
                              child: ElevatedButton(onPressed: (){
                                _uploadFile(context);
                              }, child: Text("UPLOAD"),style: ElevatedButton.styleFrom(primary:Colors.black)),
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
    );
  }
}
