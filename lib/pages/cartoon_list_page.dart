import 'package:cartoons_app/models/cartoon.dart';
import 'package:cartoons_app/pages/cartoon_detail_page.dart';
import 'package:cartoons_app/repository/fetch_cartoons.dart';
import 'package:flutter/material.dart';

class CartoonListPage extends StatefulWidget {
  const CartoonListPage({super.key});

  @override
  State<CartoonListPage> createState() => _CartoonListPage();
}

class _CartoonListPage extends State<CartoonListPage> {
  List<Cartoon> cartoons = [];
  String error = '';
  bool loading = false;

  @override
  void initState() {
    super.initState();
    _fetchCartoons();
  }

  void _fetchCartoons() async {
    try {
      setState(() {
        loading = true;
      });
      cartoons = await fetchCartoons();
      cartoons.removeWhere((cartoon) => cartoon.title.trim().isEmpty);
      error = '';
    } catch (e) {
      error = e.toString();
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  Widget buildError() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              error,
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: _fetchCartoons,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : error.isEmpty
          ? ListCartoon(cartoons: cartoons)
          : buildError(),
    );
  }
}

class ListCartoon extends StatelessWidget {
  const ListCartoon({super.key, required this.cartoons});
  final List<Cartoon> cartoons;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 3 / 4,
      ),
      itemCount: cartoons.length,
      itemBuilder: (context, index) {
        final cartoon = cartoons[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CartoonDetailPage(cartoon: cartoon),
              ),
            );
          },
          child: Card(
            elevation: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: buildImage(cartoon.image, 200, 200)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    cartoon.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget buildImage(String? url, double width, double height) {
  if (url == null || !Uri.tryParse(url)!.hasAbsolutePath == true) {
    return Center(
      child: Container(
        width: width,
        height: height,
        color: Colors.grey[300],
        child: Image.asset(
          'assets/images/ic_no_image.png',
          fit: BoxFit.contain,
          alignment: Alignment.center,
        ),
      ),
    );
  }

  return Center(
    child: Container(
      width: width,
      height: height,
      color: Colors.grey[300],
      child: Image.network(
        url,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            'assets/images/ic_no_image.png',
            fit: BoxFit.cover,
          );
        },
      ),
    ),
  );
}
