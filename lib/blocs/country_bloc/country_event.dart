import 'package:equatable/equatable.dart';

abstract class CountryEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchCountries extends CountryEvent {}
class SelectCountry extends CountryEvent {
  final String country;

  SelectCountry(this.country);

  @override
  List<Object> get props => [country];
}
