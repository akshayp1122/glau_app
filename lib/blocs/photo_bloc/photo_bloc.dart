import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glaube_app/models/photo_model.dart';
import 'package:glaube_app/repository/photo_repository.dart';
import 'photo_event.dart';
import 'photo_state.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  final PhotoRepository repository;
  int page = 0;

  PhotoBloc({required this.repository}) : super(PhotoInitial()) {
    on<FetchPhotos>(_onFetchPhotos);
  }

  Future<void> _onFetchPhotos(
      FetchPhotos event, Emitter<PhotoState> emit) async {
    if (state is PhotoLoading) return;

    final currentState = state;
    var oldPhotos = <Photo>[];

    if (currentState is PhotoLoaded) {
      oldPhotos = currentState.photos;
      if (currentState.hasReachedMax) return;
    }

    emit(PhotoLoading());

    try {
      final photos = await repository.fetchPhotos(page);
      page++;

      final allPhotos = [...oldPhotos, ...photos];
      emit(PhotoLoaded(
        photos: allPhotos,
        hasReachedMax: photos.isEmpty,
      ));
    } catch (e) {
      emit(PhotoError(e.toString()));
    }
  }
}
