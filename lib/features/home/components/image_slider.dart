import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/core/models/NewsModel.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
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
          autoPlayInterval: const Duration(seconds: 5),
          autoPlayAnimationDuration: const Duration(milliseconds: 1000),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
        ),
        items: List<Widget>.generate(widget.news!.length, (int index) {
          return Container(
            width: MediaQuery.of(context).size.height,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              image: DecorationImage(
                image: NetworkImage(
                  Urls.mainUrl +
                      widget.news![index].backgroundImage!.original!.src!,
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: AppColors.backgroundColor.withOpacity(.5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      widget.news![index].title.toString(),
                      style: Get.textTheme.labelMedium!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
