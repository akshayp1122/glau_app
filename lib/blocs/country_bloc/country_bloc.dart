import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glaube_app/repository/country_repository.dart';
import 'country_event.dart';
import 'country_state.dart';

class CountryBloc extends Bloc<CountryEvent, CountryState> {
  final CountryRepository repository;

  CountryBloc(this.repository) : super(CountryInitial()) {
    on<FetchCountries>((event, emit) async {
      emit(CountryLoading());
      try {
        final countries = await repository.fetchCountries();
        emit(CountryLoaded(countries));
      } catch (e) {
        emit(CountryError(e.toString()));
      }
    });

    on<SelectCountry>((event, emit) {
      if (state is CountryLoaded) {
        final current = state as CountryLoaded;
        emit(CountryLoaded(current.countries, selectedCountry: event.country));
      }
    });
  }
}
