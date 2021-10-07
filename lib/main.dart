
import 'package:flutter/material.dart';
import 'package:multiple_image_upload/upload.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  checkPermission() async{
    var storageStatus = await Permission.storage.status;

    print(storageStatus);
    if(!storageStatus.isGranted){
      await Permission.storage.request();
    }

    if(await Permission.storage.isGranted){
      Navigator.push(context, MaterialPageRoute(builder: (context) => UploadScreen()));
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multiple Image Upload'),
      ),
      body: Container(
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_a_photo),
        onPressed: (){
          checkPermission();
          //
        },
      ),
    );
  }
}




