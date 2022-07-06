import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ketemaa/core/Provider/postFile.dart';
import 'package:provider/provider.dart';

import '../../../core/utilities/urls/urls.dart';
class EditImage extends StatefulWidget {
  late  File? imageFile;
  EditImage({Key? key, this.imageFile}) : super(key: key);

  @override
  State<EditImage> createState() => _EditImageState();
}

class _EditImageState extends State<EditImage> {


  String? _fileName;
  String? _saveAsFileName;
  List<PlatformFile>?
  _paths;
  String? _directoryPath;
  String? _extension;
  bool _isLoading = false;
  bool _userAborted = false;
  List<File>? files = <File>[];
  List<File>? fileList = <File>[];
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();



  PostFile? postFile;



  @override
  void initState() {


    postFile = Provider.of<PostFile>(context, listen: false);

    super.initState();
  }








  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text(
        "Item Image",
        style: TextStyle(
          color: Colors.lightGreen,
        ),
      ),
      children: [
        SimpleDialogOption(
          child: const Text(
            "Capture with Camera",
            style: TextStyle(color: Colors.black),
          ),
          onPressed: captureImageWithCamera,
        ),
        SimpleDialogOption(
          child: const Text(
            "Select From Gallery",
            style: TextStyle(color: Colors.black),
          ),
          onPressed: pickImageFromGallery,
        ),
        SimpleDialogOption(
          child: const Text(
            "Cancel",
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
  }

  captureImageWithCamera() async {
    Navigator.pop(context);
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );

    _cropImage(pickedFile!.path);
  }

  pickImageFromGallery() async {
    Navigator.pop(context);

    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    _cropImage(pickedFile!.path);

  }

  void _cropImage(filePath) async{
    CroppedFile? croppedImage =await ImageCropper().cropImage(
        sourcePath: filePath,
        maxWidth: 1080,
        maxHeight: 1080);
    if(croppedImage != null){
      setState(() {
        widget.imageFile= File(croppedImage.path);
      });
    }
    print("&&&&&&&*******&&&&&"+widget.imageFile.toString());
    _pickFiles();
  }

  Future _pickFiles() async {
    _resetState();
    try {


      files!.add(widget.imageFile!);
      fileList!.addAll(files!);

      List<String> fileKey = [];

      for (int i = 0; i < fileList!.length; i++) {
        fileKey.add('image');
      }
      Map<String, String>? body = {};

      postFile!.requestWithFile(context,
          url: Urls.updateProfilePic,
          method: Method.POST,
          body: body,
          fileKey: fileKey,
          files: fileList);

      printInfo(info: 'Files' + fileList.toString());
      printInfo(info: 'Files' + _paths.toString());
    } on PlatformException catch (e) {
      _logException('Unsupported operation' + e.toString());
    } catch (e) {
      _logException(e.toString());
    }
    if (!mounted) return;
    setState(() {
      _isLoading = false;
      _fileName =
      _paths != null ? _paths!.map((e) => e.name).toString() : '...';
      _userAborted = _paths == null;
    });
  }
  void _logException(String message) {
    print(message);
    _scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _resetState() {
    if (!mounted) {
      return;
    }
    setState(() {
      _isLoading = true;
      _directoryPath = null;
      _fileName = null;
      _paths = null;
      _saveAsFileName = null;
      _userAborted = false;
    });
  }
}


