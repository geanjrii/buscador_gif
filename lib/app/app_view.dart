import 'package:buscador_gif/data_layer/giphy_api/giphy_api.dart';
import 'package:buscador_gif/domain_layer/giphy_repository/giphy_repository.dart';
import 'package:buscador_gif/feature_layer/giphy/view/giphy_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RepositoryProvider(
        create: (context) => GiphyRepository(api: GiphyApi()),
        child: const HomePage(),
      ),
    );
  }
}
