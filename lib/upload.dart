import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:multiple_image_upload/config.dart';
import 'package:path/path.dart';

class UploadScreen extends StatefulWidget {

  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {

  List<File>? image = [];
  TextEditingController titleController = TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
  }


  Future upload(File imageFile) async{
    var stream= new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var uri = Uri.parse(uploadUrl);
    
    var request = new http.MultipartRequest("POST", uri);

    
    var multipartfile = new http.MultipartFile("photo", stream, length, filename: basename(imageFile.path));

    request.fields['title'] = titleController.text;
    request.files.add(multipartfile);

    var response = await request.send();

  }


  @override
  Widget build(BuildContext context) {

    Future getImage() async{
      final ImagePicker _picker = ImagePicker();
      final List<XFile>? imagePicked = await _picker.pickMultiImage();
      image = imagePicked!.map((e) => File(e.path)).toList();

      setState(() {

      });
    }

    Widget content(){
      return Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for(File img in image!)
                Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: Image.file(
                    img,
                    fit: BoxFit.cover,
                  ),
                ),
              ElevatedButton(
                child: Text("Pick images"),
                onPressed: () async {
                  await getImage();
                },
              ),
              ElevatedButton(
                child: Text("Save images"),
                onPressed: (){
                  for(File gambar in image! ){
                    upload(gambar);
                  }
                },
              ),
              TextField(
                controller: titleController,
                decoration: new InputDecoration(
                  hintText: "Title"
                ),
              )
            ],
          ),
        ),
      );
    }
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Upload Image'),
        ),
        body: content()
      ),
    );
  }
}
