import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glaube_app/blocs/photo_bloc/photo_bloc.dart';
import 'package:glaube_app/blocs/photo_bloc/photo_event.dart';
import 'package:glaube_app/blocs/photo_bloc/photo_state.dart';

class PhotoListPage extends StatefulWidget {
  const PhotoListPage({super.key});

  @override
  State<PhotoListPage> createState() => _PhotoListPageState();
}

class _PhotoListPageState extends State<PhotoListPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<PhotoBloc>().add(FetchPhotos());
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<PhotoBloc>().add(FetchPhotos());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      appBar: AppBar(
        title: const Text(
          "Photo Gallery",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xFF0D0D0D),
      ),
      body: BlocBuilder<PhotoBloc, PhotoState>(
        builder: (context, state) {
          if (state is PhotoInitial ||
              state is PhotoLoading && state is! PhotoLoaded) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.amber));
          } else if (state is PhotoLoaded) {
            if (state.photos.isEmpty) {
              return const Center(
                child: Text(
                  "No photos found",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
              );
            }
            return ListView.builder(
              controller: _scrollController,
              itemCount: state.hasReachedMax
                  ? state.photos.length
                  : state.photos.length + 1,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                if (index >= state.photos.length) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                        child: CircularProgressIndicator(color: Colors.amber)),
                  );
                }

                final photo = state.photos[index];

                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF1F1C2C), Color(0xFF928DAB)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 10,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          photo.thumbnailUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 200,
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(14),
                          color: Colors.black.withOpacity(0.7),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                photo.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.amber,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                "Photo ID: ${photo.id} | Album: ${photo.id}",
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is PhotoError) {
            return Center(
              child: Text(
                "Error: ${state.error}",
                style: const TextStyle(color: Colors.redAccent),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
