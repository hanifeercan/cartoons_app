import 'package:cartoons_app/models/cartoon.dart';
import 'package:cartoons_app/pages/cartoon_list_page.dart';
import 'package:flutter/material.dart';

class CartoonDetailPage extends StatelessWidget {
  final Cartoon cartoon;

  const CartoonDetailPage({super.key, required this.cartoon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(cartoon.title, style: const TextStyle(fontSize: 18)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildImage(cartoon.image, 200, 300),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${cartoon.title} (${cartoon.year})",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Creator: ${cartoon.creator.join(", ")}",
                    style: const TextStyle(fontSize: 16),
                  ),

                  const SizedBox(height: 12),

                  // Genre chips
                  Wrap(
                    spacing: 8.0,
                    children: cartoon.genre
                        .map(
                          (g) => Chip(
                            label: Text(g),
                            backgroundColor: Colors.blue.shade100,
                          ),
                        )
                        .toList(),
                  ),

                  const SizedBox(height: 16),

                  // Rating, Runtime, Episodes
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InfoTile(label: "Rating", value: cartoon.rating),
                      InfoTile(
                        label: "Runtime",
                        value: "${cartoon.runtime_in_minutes} min",
                      ),
                      InfoTile(label: "Episodes", value: "${cartoon.episodes}"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoTile extends StatelessWidget {
  final String label;
  final String value;

  const InfoTile({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}
