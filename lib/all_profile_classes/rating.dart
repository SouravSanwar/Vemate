import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class ImportImage extends StatefulWidget {
  const ImportImage({Key? key}) : super(key: key);

  @override
  _ImportImageState createState() => _ImportImageState();
}

class _ImportImageState extends State<ImportImage> {

  //Imagepicker
  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();
  String sellerImageUrl = "";

  Future<void> _getImage() async {
    imageXFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageXFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
