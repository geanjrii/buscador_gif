// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:buscador_gif/feature_layer/giphy/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:transparent_image/transparent_image.dart';

import 'gif_page.dart';

class Grid extends StatelessWidget {
  const Grid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final length = context.read<GiphyCubit>().state.list.length;
    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: length,
            itemBuilder: (context, index) {
              final imgUrl =
                  context.read<GiphyCubit>().state.list[index].imgUrl;
              final title = context.read<GiphyCubit>().state.list[index].title;
              if (index == length - 1) {
                return const LoadMoreButton();
              } else {
                return GridItem(
                  imgUrl: imgUrl,
                  title: title,
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

class LoadMoreButton extends StatelessWidget {
  const LoadMoreButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: 1,
        ),
      ),
      child: IconButton(
        icon: const Icon(
          Icons.more_horiz_rounded,
          color: Colors.white,
        ),
        onPressed: () => context.read<GiphyCubit>().onMoreDataLoaded(),
        iconSize: 30,
        padding: const EdgeInsets.all(10),
        splashRadius: 20,
        color: Colors.white,
        constraints: const BoxConstraints(),
        style: ButtonStyle(iconSize: MaterialStateProperty.all(30)),
      ),
    );
  }
}

class GridItem extends StatelessWidget {
  const GridItem({
    super.key,
    required this.imgUrl,
    required this.title,
  });

  final String imgUrl;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, GifPage.router(title, imgUrl)),
      onLongPress: () => Share.share(imgUrl),
      child: FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: imgUrl,
        height: 300,
        fit: BoxFit.cover,
      ),
    );
  }
}
