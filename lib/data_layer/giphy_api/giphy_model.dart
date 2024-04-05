import 'package:equatable/equatable.dart';

class GiphyModel extends Equatable {
  final String title;
  final String imgUrl;

  const GiphyModel({
    required this.title,
    required this.imgUrl,
  });

  factory GiphyModel.fromJson(Map<String, dynamic> json) {
    return GiphyModel(
      title: json['title'] ?? "",
      imgUrl: json['images']['fixed_height']['url'] ?? "",
    );
  }

  @override
  List<Object?> get props => [title, imgUrl];
}
