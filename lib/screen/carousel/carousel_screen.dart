// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mireno_movie/provider/discover/discover_provider.dart';
import 'package:mireno_movie/screen/widget/listview/pelicula_item.dart';


class CarouselSliderWidget extends StatelessWidget {
  final PeliculaProvider nowPlayingMovies;

  const CarouselSliderWidget({super.key, required this.nowPlayingMovies});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: nowPlayingMovies == null
          ? [const Center(
              child: CircularProgressIndicator(),
            )]
          : nowPlayingMovies.results
              ?.map((movieItem) =>PeliculaItem(peliItem: movieItem))
              .toList(),
      options: CarouselOptions(
        height: 240,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 4),
        autoPlayCurve: Curves.fastOutSlowIn,
        scrollDirection: Axis.horizontal,
        viewportFraction: 0.8,
      ),
    );
  }
}