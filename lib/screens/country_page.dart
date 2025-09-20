import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glaube_app/blocs/country_bloc/country_bloc.dart';
import 'package:glaube_app/blocs/country_bloc/country_event.dart';
import 'package:glaube_app/blocs/country_bloc/country_state.dart';
import 'package:glaube_app/repository/country_repository.dart';

class CountryPage extends StatelessWidget {
  const CountryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CountryBloc(CountryRepository())..add(FetchCountries()),
      child: Scaffold(
        backgroundColor: const Color(0xFF121212), 
        appBar: AppBar(
          backgroundColor: const Color(0xFF121212),
          elevation: 0,
          title: const Text(
            "Select Country",
            style: TextStyle(
              color: Color(0xFFD4AF37), 
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<CountryBloc, CountryState>(
            builder: (context, state) {
              if (state is CountryLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFFD4AF37),
                  ),
                );
              } else if (state is CountryLoaded) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Choose your country:",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFD4AF37), width: 1.5),
                      ),
                      child: DropdownButton<String>(
                        value: state.selectedCountry,
                        hint: const Text(
                          "Select Country",
                          style: TextStyle(color: Colors.white70),
                        ),
                        isExpanded: true,
                        dropdownColor: Colors.black,
                        iconEnabledColor: const Color(0xFFD4AF37),
                        underline: const SizedBox(),
                        items: state.countries
                            .map((country) => DropdownMenuItem(
                                  value: country,
                                  child: Text(
                                    country,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ))
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            context.read<CountryBloc>().add(SelectCountry(value));
                          }
                        },
                      ),
                    ),
                    if (state.selectedCountry != null) ...[
                      const SizedBox(height: 24),
                      Text(
                        "Selected: ${state.selectedCountry}",
                        style: const TextStyle(
                          color: Color(0xFFD4AF37),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ]
                  ],
                );
              } else if (state is CountryError) {
                return Center(
                  child: Text(
                    state.message,
                    style: const TextStyle(color: Colors.redAccent),
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
