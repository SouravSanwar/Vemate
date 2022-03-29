import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';

class ImageSlider extends StatelessWidget{

  final items=[
    "slider/11.jpg",
    "slider/12.jpg",
    "slider/13.jpg",];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CarouselSlider(
        options: CarouselOptions(
          height: MediaQuery.of(context).size.height*.17,
          aspectRatio: 16/9,
          viewportFraction: 0.8,
          initialPage: 0,
          //again starts from first image
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 2),
          autoPlayAnimationDuration: const Duration(milliseconds: 500),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
        ),
        items: items.map((index) {
          return Builder(builder: (BuildContext){
            return Container(
              width: MediaQuery.of(context).size.height,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.asset(
                  index,
                  fit: BoxFit.fill,
                ),
              ),
            );
          });
        }).toList(),
      ),

    );
  }

}