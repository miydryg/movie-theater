

import '../../repository/repository.dart';
import 'movie_state.dart';
import 'movie_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState>{
  final MovieRepository _movieRepository;

  MovieBloc(this._movieRepository) : super(MovieLoadingState()){
    on<LoadMovieEvent>((event, emit) async {
      emit(MovieLoadingState());
      try {
        final movies = await _movieRepository.getMovies();
        emit(MovieLoadedState(movies));
      } catch(e) {
        emit(MovieErrorState(e.toString()));
      }

    });
  }
}