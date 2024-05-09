import 'package:flutter/material.dart';
import 'package:revisi_film/controller/api_data_source.dart';
import 'package:revisi_film/model/detail_film.dart';
// ignore: depend_on_referenced_packages
import 'package:url_launcher/url_launcher.dart';

class PageDetailFilm extends StatefulWidget {
  final String imdbid;
  const PageDetailFilm({Key? key, required this.imdbid}) : super(key: key);

  @override
  State<PageDetailFilm> createState() => _PageDetailFilmState();
}

class _PageDetailFilmState extends State<PageDetailFilm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Film"),
      ),
      body: _buildDetailFilm(),
    );
  }

  Widget _buildDetailFilm() {
    return Container(
        child: FutureBuilder(
            future: ApiDataSource.instance.loadDetailFilm(widget.imdbid),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasError) {
                // Jika data ada error maka akan ditampilkan hasil error
                return _buildErrorSection();
              }
              if (snapshot.hasData) {
                // Jika data ada dan berhasil maka akan ditampilkan hasil datanya
                DetailFilm detailFilm = DetailFilm.fromJson(snapshot.data);
                return _buildItemUsers(detailFilm);
              }
              return _buildLoadingSection();
            }));
  }

  Widget _buildErrorSection() {
    return const Text("Error");
  }

  Widget _buildLoadingSection() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildItemUsers(DetailFilm detailFilm) {
    return ListView(children: [
      Column(
        children: [
          Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Container(
                    child: Image.network(
                      detailFilm.poster!,
                      width: 200,
                    ),
                  ),
                ),
                Text(detailFilm.title!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                        // color: Colors.white
                        )),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(detailFilm.year! +
                          " • " +
                          detailFilm.rated! +
                          " • " +
                          detailFilm.runtime!)
                    ],
                  ),
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(detailFilm.country! + " | "),
                      const Icon(Icons.star, color: Colors.yellowAccent),
                      Text(detailFilm.imdbRating!),
                    ],
                  ),
                ),
                const SizedBox(height: 15.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Text(
                            'Type',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Text(detailFilm.type!),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Text(
                            'Votes',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Text(detailFilm.imdbVotes!)
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Text(
                            'Awards',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Text(detailFilm.awards!),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Text(
                            'Date Released',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Text(detailFilm.released!),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Text(
                            'Genre',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Text(detailFilm.genre!),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Text(
                            'Language',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Text(detailFilm.language!),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Text(
                            'Plot',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Text(detailFilm.plot!),
                      const SizedBox(height: 15.0)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ]);
  }
}
