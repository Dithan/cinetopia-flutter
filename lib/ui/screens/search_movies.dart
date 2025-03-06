import 'package:cinetopia/app/viewmodels/search_movies_viewmodel.dart';
import 'package:cinetopia/ui/components/movie_card.dart';
import 'package:cinetopia/ui/screens/movie_details.dart';
import 'package:flutter/material.dart';

class SearchMovies extends StatefulWidget {
  SearchMovies({super.key});

  @override
  State<SearchMovies> createState() => _SearchMoviesState();
}

class _SearchMoviesState extends State<SearchMovies> {
  final SearchMoviesViewmodel viewmodel = SearchMoviesViewmodel();

  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: viewmodel.getMovie(textController.text),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                  child:
                      Image.asset("assets/popular.png", height: 86, width: 86)),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 16, 0, 32),
                  child: Text(
                    "Filmes Populares",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: TextField(
                  controller: textController,
                  onEditingComplete: () {
                    FocusScope.of(context).unfocus();
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16)),
                    hintText: "Pesquisar",
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                sliver: SliverList.builder(
                  itemBuilder: (context, index) => InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MovieDetails(movie: viewmodel.moviesList[index]),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: MovieCard(movie: viewmodel.moviesList[index]),
                    ),
                  ),
                  itemCount: viewmodel.moviesList.length,
                ),
              )
            ],
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
