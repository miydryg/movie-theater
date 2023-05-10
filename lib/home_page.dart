
import 'dart:ui';

import 'package:cinema_bloc_ui/repository/repository.dart';

import 'package:cinema_bloc_ui/widgets/text.dart';
import 'package:flutter/material.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bloc/movie_bloc.dart';
import 'bloc/bloc/movie_event.dart';
import 'bloc/bloc/movie_state.dart';
import 'details_movie_page.dart';
import 'models/model/movie_model.dart';
import 'models/movie_model.dart';
import 'models/trailers_model.dart';

class HomeCinePage extends StatelessWidget {
  const HomeCinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff21242C),
      appBar: AppBar(
        backgroundColor: const Color(0xff21242C),
        leading: const Icon(Icons.menu, color: Colors.white, size: 30),
        elevation: 0,
        actions: const [
          Icon(Icons.search, size: 30),
          SizedBox(width: 10.0),
          Icon(Icons.notifications_rounded, size: 30),
          SizedBox(width: 15.0),
          SizedBox(width: 15.0),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        children: [
          const _ItemTitle(title: 'Trailes'),
          const SizedBox(height: 20.0),
          Container(
            margin: const EdgeInsets.only(left: 20.0),
            height: 200,
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: TrailersMovie.listTrailers.length,
                itemBuilder: (context, i) =>
                    _ItemTrailers(trailers: TrailersMovie.listTrailers[i])),
          ),
          const SizedBox(height: 20.0),
          const _ItemTitle(title: 'Now in Cinemas'),
          Container(
            margin: const EdgeInsets.only(left: 20.0),
            height: 280,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: MovieModel.listMovie.length,
              itemBuilder: (context, i) =>
                  _ItemsNowCinemas(movieModel: MovieModel.listMovie[i]),
            ),
          ),
          const SizedBox(height: 20.0),
          const _ItemTitle(title: 'Now in Cinemas Api'),
          Container(
            margin: const EdgeInsets.only(left: 20.0),
            height: 280,
            child: RepositoryProvider(
              create: (context) => MovieRepository(),
              child: const MovieFromApi(),
            ),
          ),
          const SizedBox(height: 20.0),
          const _ItemTitle(title: 'Coming Soon'),
          Container(
            margin: const EdgeInsets.only(left: 20.0),
            height: 280,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, i) =>
                  _ItemsSoonMovie(movieModel: MovieModel.listMovie[i + 2]),
            ),
          ),
        ],
      ),
    );
  }
}

class _ItemsSoonMovie extends StatelessWidget {
  final MovieModel movieModel;

  const _ItemsSoonMovie({Key? key, required this.movieModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.only(right: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 210,
              width: 160,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                      fit: BoxFit.cover, image: AssetImage(movieModel.image))),
            ),
            const SizedBox(height: 15.0),
            SizedBox(
              width: 160,
              child: TextFrave(text: movieModel.name, color: Colors.white),
            ),
            const SizedBox(height: 5.0),
            RatingBar.builder(
                itemSize: 22,
                initialRating: movieModel.qualification,
                itemBuilder: (_, i) =>
                    const Icon(Icons.star_rate_rounded, color: Colors.amber),
                onRatingUpdate: (_) {})
          ],
        ),
      ),
    );
  }
}

class _ItemsNowCinemas extends StatelessWidget {
  final MovieModel movieModel;

  const _ItemsNowCinemas({Key? key, required this.movieModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => DetailsMoviePage(movieModel: movieModel))),
      child: Padding(
        padding: const EdgeInsets.only(right: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'movie-hero-${movieModel.id}',
              child: Container(
                height: 210,
                width: 160,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(movieModel.image))),
              ),
            ),
            const SizedBox(height: 15.0),
            SizedBox(
              width: 160,
              child: TextFrave(text: movieModel.name, color: Colors.white),
            ),
            const SizedBox(height: 5.0),
            RatingBar.builder(
                itemSize: 22,
                initialRating: movieModel.qualification,
                itemBuilder: (_, i) =>
                    const Icon(Icons.star_rate_rounded, color: Colors.amber),
                onRatingUpdate: (_) {})
          ],
        ),
      ),
    );
  }
}

class _ItemTitle extends StatelessWidget {
  final String title;

  const _ItemTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextFrave(
                text: title,
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.w500),
            const TextFrave(text: 'View all', color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

class _ItemTrailers extends StatelessWidget {
  final TrailersMovie trailers;

  const _ItemTrailers({Key? key, required this.trailers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: Stack(
        children: [
          Container(
            width: 300,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                    fit: BoxFit.cover, image: AssetImage(trailers.image))),
          ),
          SizedBox(
            width: 300,
            child: Center(
                child: ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 10.0,
                  sigmaY: 10.0,
                ),
                child: Container(
                    padding: const EdgeInsets.all(15),
                    color: Colors.white.withOpacity(0.3),
                    child: const Icon(Icons.play_arrow_rounded,
                        color: Colors.white, size: 45)),
              ),
            )),
          )
        ],
      ),
    );
  }
}

class MovieFromApi extends StatelessWidget {
  const MovieFromApi({Key? key, required}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => MovieBloc(
              RepositoryProvider.of<MovieRepository>(context),
            )..add(LoadMovieEvent()),
        child: Column(
          children: [
            SizedBox(
              height: 280,
              child: BlocBuilder<MovieBloc, MovieState>(
                builder: (context, state) {
                  if (state is MovieLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is MovieLoadedState) {
                    List<MovieModelApi> movieList =
                        state.movies.cast<MovieModelApi>();
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: movieList.length,
                        itemBuilder: (_, index) {
                          return InkWell(
                            // onTap: () => Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (_) => DetailsMoviePage(
                            //               movieModel: movieModel,
                            //             ))),
                            child: Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Hero(
                                    tag: 'movie-hero-${movieList[index].id}',
                                    child: Container(
                                      height: 210,
                                      width: 160,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  movieList[index]
                                                      .smallImage))),
                                    ),
                                  ),
                                  const SizedBox(height: 15.0),
                                  SizedBox(
                                    width: 160,
                                    child: TextFrave(
                                        text: movieList[index].name,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  }

                  return Container();
                },
              ),
            ),
          ],
        ));
  }
}
