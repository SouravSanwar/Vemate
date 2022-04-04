import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:ketemaa/core/models/NewsModel.dart';
import 'package:ketemaa/core/utilities/urls/urls.dart';

class ImageSlider extends StatefulWidget {
  final List<Results>? news;

  const ImageSlider({Key? key, this.news}) : super(key: key);

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  final items = [
    "assets/media/slider/11.jpg",
    "assets/media/slider/12.jpg",
    "assets/media/slider/13.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CarouselSlider(
        options: CarouselOptions(
          height: MediaQuery.of(context).size.height * .17,
          aspectRatio: 16 / 9,
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
        items: List<Widget>.generate(
            widget.news!.length, (int index) {
          return Container(
            width: MediaQuery.of(context).size.height,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                Urls.mainUrl +
                    widget.news![index].backgroundImage!.original!.src!,
                fit: BoxFit.fill,
              ),
            ),
          );
        }),
        /*items: widget.news!.map((index) {
          return Builder(builder: (BuildContext) {
            return Container(
              width: MediaQuery.of(context).size.height,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  Urls.mainUrl +
                      widget.news![0].backgroundImage!.original!.src!,
                  fit: BoxFit.fill,
                ),
              ),
            );
          });
        }).toList(),*/
      ),
    );
  }
}
