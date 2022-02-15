import 'package:flutter/material.dart';
import 'package:flutter_image_slider/carousel.dart';
import 'package:ketemaa/core/utilities/app_dimension/app_sizes.dart';

class ImageSliderSection extends StatefulWidget {
  List<String>? images = [];

  ImageSliderSection({this.images});

  @override
  _ImageSliderSectionState createState() => _ImageSliderSectionState();
}

class _ImageSliderSectionState extends State<ImageSliderSection> {
  List<Widget> _imageWidget() {
    List<Widget> _sliderImages= [];
    for (var i = 0; i < widget.images!.length; i++) {
      Widget _imageSlider = Image.asset(
        widget.images![i],
        fit: BoxFit.fill,
      );
      _sliderImages.add(_imageSlider);
      //print('Image View: ${widget.images![i]}');
    }
    return _sliderImages;
  }

  @override
  Widget build(BuildContext context) {
    /*print(
        'Image Widget List ${_imageWidget()}\n List Length : ${widget.images!.length}');*/
    return Center(
      child: Container(
        height: AppSizes.height3,
        width: AppSizes.width8,
        child: _imageWidget() == null
            ? Container(
                height: AppSizes.height3,
                width: AppSizes.width8,
                child: Center(
                  child: Text('No Image'),
                ),
              )
            : Carousel(
                indicatorBarColor: Colors.transparent,
                autoScrollDuration: Duration(seconds: 2),
                animationPageDuration: Duration(milliseconds: 500),
                activateIndicatorColor: Colors.black,
                animationPageCurve: Curves.ease,
                indicatorBarHeight: 0,
                indicatorHeight: 0,
                indicatorWidth: 0,
                unActivatedIndicatorColor: Colors.grey,
                //stopAtEnd: true,
                autoScroll: true,
                isCircle: true,
                // widgets
                items: _imageWidget(),
              ),
      ),
    );
  }
}
