

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:networks_app/model/request_vs_response/request_model.dart';
import 'package:networks_app/model/request_vs_response/response_model.dart';
import 'package:networks_app/services/dio_app/dio_network_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final id=TextEditingController();
  final title=TextEditingController();
  final dervice=DioNetworkService();

  void onPublish()async{
   
   try {
      if(title.text.isEmpty)return;
      final body=RequestBodyModel(userId:id.text, title: title.text);
      ResponseModel? response= await dervice.addPost(body);
      showModalBottomSheet(context: context,
       builder:(context) => Text(response!.userId.toString(),style: TextStyle(
        fontSize: 18,fontWeight: FontWeight.w500,
       ),),
       );
   } catch (e) {
     log(e.toString());
   }
  }
    @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: SafeArea(child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
    CupertinoTextField(
     placeholder: 'title',
      controller: title,
    ),
     CupertinoTextField(
     placeholder: 'id',
      controller: id,
    ),

    CupertinoButton.filled(child:Text('Publish'),
     onPressed:onPublish)
    

      ],
    )),

    );
  }
}