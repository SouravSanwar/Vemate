import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class VeVeLowImage extends StatefulWidget {

  final String imageUrl;

  const VeVeLowImage({Key? key,required this.imageUrl}) : super(key: key);

  @override
  State<VeVeLowImage> createState() => _VeVeLowImageState();
}

class _VeVeLowImageState extends State<VeVeLowImage> {
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: widget.imageUrl,
      imageBuilder: (context,
          imageProvider) =>
          Container(
            decoration: BoxDecoration(
              borderRadius:
              BorderRadius.circular(
                  10),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.fill,
              ),
            ),
          ),
      placeholder: _loader,
    );
  }
  Widget _loader(BuildContext context, String url) {
    return const ImageIcon(
      AssetImage('assets/media/icon/logo_v.png'),
      color: Color(0xFF3A5A98),
    );
  }
}



class FirstLetterImage extends StatefulWidget {
  final String firstLetter;
  final double fontsize;
  const FirstLetterImage({Key? key, required this.firstLetter, required this.fontsize}) : super(key: key);

  @override
  State<FirstLetterImage> createState() => _FirstLetterImageState();
}

class _FirstLetterImageState extends State<FirstLetterImage> {

  @override
  Widget build(BuildContext context) {


    return Text(
      widget.firstLetter,
      style: TextStyle(
        ////fontFamily: 'Inter',
          color: Colors.deepPurpleAccent,
          fontSize: widget.fontsize,
          fontWeight:
          FontWeight.bold),
    );
  }
}
