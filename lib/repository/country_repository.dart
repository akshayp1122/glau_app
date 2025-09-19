import 'dart:convert';
import 'package:http/http.dart' as http;

class CountryRepository {
  final String apiUrl =
      "https://countriesnow.space/api/v0.1/countries/population/cities";

  Future<List<String>> fetchCountries() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final List data = body['data'];

     
      final countries = data.map((e) => e['country'] as String).toSet().toList();
      countries.sort();
      return countries;
    } else {
      throw Exception("Failed to load countries");
    }
  }
}
