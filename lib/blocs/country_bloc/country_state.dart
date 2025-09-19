import 'package:equatable/equatable.dart';

abstract class CountryState extends Equatable {
  @override
  List<Object> get props => [];
}

class CountryInitial extends CountryState {}
class CountryLoading extends CountryState {}
class CountryLoaded extends CountryState {
  final List<String> countries;
  final String? selectedCountry;

  CountryLoaded(this.countries, {this.selectedCountry});

  @override
  List<Object> get props => [countries, selectedCountry ?? ""];
}
class CountryError extends CountryState {
  final String message;
  CountryError(this.message);

  @override
  List<Object> get props => [message];
}
