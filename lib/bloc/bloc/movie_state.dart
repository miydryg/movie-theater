import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../models/model/movie_model.dart';




@immutable
abstract class MovieState extends Equatable{}

class MovieLoadingState extends MovieState {
  @override
  List<Object?> get props => [];
}

class MovieLoadedState extends MovieState {
 MovieLoadedState(this.movies);
  final List<MovieModelApi> movies;

  @override
  List<Object?> get props => [movies];
}

class MovieErrorState extends MovieState {

  MovieErrorState(this.error);
  final String error;

  @override
  List<Object?> get props => [error];
}