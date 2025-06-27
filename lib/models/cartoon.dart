import 'dart:convert';

import 'package:equatable/equatable.dart';

class Cartoon extends Equatable {
  final String title;
  final int year;
  final List<String> creator;
  final String rating;
  final List<String> genre;
  final int runtime_in_minutes;
  final int episodes;
  final String image;
  final int id;
  const Cartoon({
    required this.title,
    required this.year,
    required this.creator,
    required this.rating,
    required this.genre,
    required this.runtime_in_minutes,
    required this.episodes,
    required this.image,
    required this.id,
  });

  Cartoon copyWith({
    String? title,
    int? year,
    List<String>? creator,
    String? rating,
    List<String>? genre,
    int? runtime_in_minutes,
    int? episodes,
    String? image,
    int? id,
  }) {
    return Cartoon(
      title: title ?? this.title,
      year: year ?? this.year,
      creator: creator ?? this.creator,
      rating: rating ?? this.rating,
      genre: genre ?? this.genre,
      runtime_in_minutes: runtime_in_minutes ?? this.runtime_in_minutes,
      episodes: episodes ?? this.episodes,
      image: image ?? this.image,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'year': year,
      'creator': creator,
      'rating': rating,
      'genre': genre,
      'runtime_in_minutes': runtime_in_minutes,
      'episodes': episodes,
      'image': image,
      'id': id,
    };
  }

  factory Cartoon.fromMap(Map<String, dynamic> map) {
    return Cartoon(
      title: map['title'] ?? '',
      year: map['year']?.toInt() ?? 0,
      creator: List<String>.from(map['creator']),
      rating: map['rating'] ?? '',
      genre: List<String>.from(map['genre']),
      runtime_in_minutes: map['runtime_in_minutes']?.toInt() ?? 0,
      episodes: map['episodes']?.toInt() ?? 0,
      image: map['image'] ?? '',
      id: map['id']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Cartoon.fromJson(String source) =>
      Cartoon.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Cartoon(title: $title, year: $year, creator: $creator, rating: $rating, genre: $genre, runtime_in_minutes: $runtime_in_minutes, episodes: $episodes, image: $image, id: $id)';
  }

  @override
  List<Object> get props {
    return [
      title,
      year,
      creator,
      rating,
      genre,
      runtime_in_minutes,
      episodes,
      image,
      id,
    ];
  }
}
