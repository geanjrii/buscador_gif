// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:buscador_gif/data_layer/data_layer.dart';
import 'package:buscador_gif/domain_layer/giphy_repository/giphy_repository.dart';
import 'package:buscador_gif/feature_layer/giphy/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/grid.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GiphyCubit(repository: context.read<GiphyRepository>())
            ..onDataLoaded(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.network(GiphyApi.imgBar),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const SearchTextField(),
          BlocBuilder<GiphyCubit, GiphyState>(
            builder: (context, state) {
              return Expanded(
                  child: switch (context.read<GiphyCubit>().state.apiStatus) {
                LoadingStatus.loading => const Loading(),
                LoadingStatus.failure => Container(),
                LoadingStatus.success => const Grid(),
              });
            },
          ),
        ],
      ),
    );
  }
}

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextField(
        decoration: const InputDecoration(
          labelText: 'Pesquise aqui',
          labelStyle: TextStyle(color: Colors.white),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        style: const TextStyle(color: Colors.white, fontSize: 18),
        textAlign: TextAlign.center,
        onSubmitted: (text) =>
            context.read<GiphyCubit>().onSearchSubmitted(text),
      ),
    );
  }
}

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      alignment: Alignment.center,
      child: const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        strokeWidth: 5,
      ),
    );
  }
}
