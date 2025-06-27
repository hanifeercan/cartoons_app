import 'package:dio/dio.dart';
import 'package:cartoons_app/models/cartoon.dart';

Future<List<Cartoon>> fetchCartoons() async {
  try {
    final Response response = await Dio().get(
      'https://api.sampleapis.com/cartoons/cartoons2D',
    );
    final List cartoonList = response.data;
    print(cartoonList[0]);

    final cartoons = [
      for (final cartoon in cartoonList) Cartoon.fromMap(cartoon),
    ];
    print(cartoons[0]);
    return cartoons;
  } catch (e) {
    rethrow;
  }
}
