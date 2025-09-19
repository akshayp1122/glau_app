import 'package:equatable/equatable.dart';
import 'package:glaube_app/models/photo_model.dart';


abstract class PhotoState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PhotoInitial extends PhotoState {}

class PhotoLoading extends PhotoState {}

class PhotoLoaded extends PhotoState {
  final List<Photo> photos;
  final bool hasReachedMax;

  PhotoLoaded({required this.photos, required this.hasReachedMax});

  PhotoLoaded copyWith({List<Photo>? photos, bool? hasReachedMax}) {
    return PhotoLoaded(
      photos: photos ?? this.photos,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [photos, hasReachedMax];
}

class PhotoError extends PhotoState {
  final String error;

  PhotoError(this.error);

  @override
  List<Object?> get props => [error];
}