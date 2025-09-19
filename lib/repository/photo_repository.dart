import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:glaube_app/models/photo_model.dart';

class PhotoRepository {
  final int limit = 20;

  Future<List<Photo>> fetchPhotos(int page) async {
    final response = await http.get(
      Uri.parse(
          "https://jsonplaceholder.typicode.com/photos?_start=${page * limit}&_limit=$limit"),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      return data.map((e) {
        final photo = Photo.fromJson(e);
        return Photo(
          id: photo.id,
          title: photo.title,
          url: "https://picsum.photos/id/${photo.id}/600/400",
          thumbnailUrl: "https://picsum.photos/id/${photo.id}/150/150",
        );
      }).toList();
    } else {
      throw Exception("Failed to load photos");
    }
  }
}
