
import 'package:flutter/material.dart';
import 'package:mireno_movie/provider/api/api_provider.dart';

class HeaderWidget extends StatelessWidget {
  final Widget carouselSlider;
  final String title;

  const HeaderWidget({super.key, required this.carouselSlider, required this.title});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: const Center(
        child: Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: Text(
            "Presentando en cines",
            style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      expandedHeight: 290.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            Image.network("${baseImageUrl}w500/7IiTTgloJzvGI1TAYymCfbfl3vT.jpg",
              fit: BoxFit.cover,
              width: 1000.0,
              colorBlendMode: BlendMode.dstATop,
              color: Colors.grey.withOpacity(0.3),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 35.0),
              child: Column(
                children: [
                  carouselSlider
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}