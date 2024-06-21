import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mireno_movie/provider/discover/discover_provider.dart';
import 'package:mireno_movie/screen/widget/model/staff.dart';
import 'dart:convert';
import './widget/model/pelicula_detalles.dart';
import 'package:http/http.dart' as http;
import 'package:mireno_movie/provider/api/api_provider.dart';
import 'package:intl/intl.dart';

const apiKey =
    'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5MWM2OTIwYTY1M2U2NTRhZGNjNjhmYmJkNmYzZWYyNCIsInN1YiI6IjY2NTEwZDljZmY0OWFkZTZhYzk1ZDdmOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.i_pfpJLphqBz8NNsS2MNI6bj1-OFndAou3qpAyBs_gM';
const baseUrl = 'https://api.themoviedb.org/3/movie/';

class Detalles extends StatefulWidget {
  final Results movie;
  const Detalles({super.key, required this.movie});

  @override
  State<Detalles> createState() => _DetallesState();
}

class _DetallesState extends State<Detalles> {
  late String movieDataUrl;
  late String staffUrl;
  MovieModel? movieModel;
  Staff? personal;

  @override
  void initState() {
    super.initState();
    movieDataUrl = '$baseUrl${widget.movie.id}?language=en-US';
    staffUrl = '$baseUrl${widget.movie.id}/credits';
    fetchMovieData();
    fetchStaffData();
  }

  void fetchMovieData() async {
    try {
      var decodedJson;
      final response = await http.get(Uri.parse(movieDataUrl), headers: {
        'Authorization': 'Bearer $apiKey',
        'Accept': 'application/json',
      });
      if (response.statusCode == 200) {
        setState(() {
          movieModel = MovieModel.fromJson(json.decode(response.body));
        });
      } else {
        throw Exception('Failed to load movie data');
      }
    } catch (e) {
      print('Error fetching movie data: $e');
      // Puedes manejar el error de alguna manera aquí, como mostrando un mensaje de error en la interfaz de usuario.
    }
  }

  void fetchStaffData() async {
    try {
      final response = await http.get(Uri.parse(staffUrl), headers: {
        'Authorization': 'Bearer $apiKey',
        'Accept': 'application/json',
      });

      if (response.statusCode == 200) {
        setState(() {
          personal = Staff.fromJson(json.decode(response.body));
        });
      } else {
        throw Exception('Failed to load staff data');
      }
    } catch (e) {
      print('Error fetching staff data: $e');
      // Puedes manejar el error de alguna manera aquí, como mostrando un mensaje de error en la interfaz de usuario.
    }
  }

  String getDuracion(int runtime) {
    if (movieModel == null || runtime == null) return 'no presenta duracion';
    double peliHoras = runtime / 60;
    int peliMinutos = ((peliHoras - peliHoras.floor()) * 60).round();
    return "${peliHoras.floor()}h ${peliMinutos}min";
  }

  @override
  Widget build(BuildContext context) {
    final poster = Container(
      height: 350,
      padding: const EdgeInsets.only(top: 10.0, bottom: 8.0),
      child: Center(
        child: Card(
          elevation: 20.0,
          child: Hero(
              tag: widget.movie.counter ?? 'default_tag',
              child: Image.network(
                "${baseImageUrl}w342${widget.movie.posterPath}",
                fit: BoxFit.cover,
              )),
        ),
      ),
    );

    final titulo = Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 4.0),
      child: Center(
        child: Text(
          widget.movie.title ?? 'default_tag',
          style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );

    final time = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          movieModel != null
              ? getDuracion(movieModel?.runtime ?? 0)
              : 'Loading...',
          style: const TextStyle(fontSize: 12.0),
        ),
        Container(
          height: 20.0,
          width: 1.0,
          color: Colors.white70,
        ),
        Text(
            'Fecha Creacion: ${DateFormat('dd-mm-yyyy').format(DateTime.parse(widget.movie.releaseDate ?? 'N/A'))}'),
        const Icon(Icons.timer)
      ],
    );

    final generoList = Center(
      child: SizedBox(
        height: 25.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: movieModel == null
              ? []
              : movieModel!.genres
                      ?.map((g) => Padding(
                            padding:
                                const EdgeInsets.only(right: 6.0, left: 15.0),
                            child: FilterChip(
                              backgroundColor: Colors.red.shade500,
                              labelStyle: const TextStyle(fontSize: 10.0),
                              label: Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(g.name ?? ''),
                              ),
                              onSelected: (b) {},
                            ),
                          ))
                      .toList() ??
                  [],
        ),
      ),
    );

    final sinopsis = Container(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 3.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),
          const Text(
            'SINOPSIS',
            style: TextStyle(
                fontFamily: AutofillHints.creditCardType,
                fontWeight: FontWeight.bold,
                color: Colors.grey),
          ),
          const SizedBox(
            height: 11.0,
          ),
          Text(
            widget.movie.overview ?? '',
            style: TextStyle(color: Colors.grey[300], fontSize: 12.0),
          ),
          const SizedBox(
            height: 10.0,
          )
        ],
      ),
    );

final staffContent = Container(
  height: 110.0,
  padding: const EdgeInsets.only(
    top: 10.0,
  ),
  decoration: BoxDecoration(
    color: Colors.black.withOpacity(0.1),
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 11.0, bottom: 8.0),
        child: Text(
          'Actores',
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
          ),
        ),
      ),
      Flexible(
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: personal == null
              ? [const Center(child: CircularProgressIndicator())]
              : personal?.cast
                  ?.map((c) => Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: SizedBox(
                        width: 65.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 20.0,
                              backgroundImage: c.profilePath != null
                                  ? NetworkImage('${baseImageUrl}w154${c.profilePath}', )
                                  : const NetworkImage('https://i.pinimg.com/564x/43/de/24/43de2488977ee2819e842816617c70d7.jpg'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                c.name ?? '',
                                style: const TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                c.character ?? '',
                                style: const TextStyle(fontSize: 9.0),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ))
                  .toList() ??
          [],
        ),
      ),
    ],
  ),
);



  return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: const Text(
          'Minero App',
          style: TextStyle(
            color: Colors.red,
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: movieModel == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    poster,
                    const SizedBox(height: 10.0),
                    titulo,
                    const SizedBox(height: 10.0),
                    time,
                    const SizedBox(height: 10.0),
                    generoList,
                    const SizedBox(height: 10.0),
                    sinopsis,
                    const SizedBox(height: 10.0),
                    staffContent,
                  ],
                ),
              ),
            ),
    );
  }
}