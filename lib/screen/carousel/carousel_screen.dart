import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mireno_movie/provider/discover/discover_provider.dart';

const baseImageUrl = 'http://image.tmdb.org/t/p/';

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
              ?.map((movieItem) =>
                  Image.network("${baseImageUrl}w342${movieItem.posterPath}"))
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