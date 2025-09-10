import 'package:flutter/material.dart';
import 'package:restaurant_api_dicoding/data/model/restauran.dart';

class BodyOfDetailScreenWidget extends StatelessWidget {
  const BodyOfDetailScreenWidget({super.key, required this.restauran});

  final Restauran restauran;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              "https://restaurant-api.dicoding.dev/images/medium/${restauran.pictureId}",
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.broken_image);
              },
            ),
          ),

          SizedBox.square(dimension: 16),

          Text(
            restauran.name,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Text("${restauran.city} • ⭐ ${restauran.rating}"),

          const SizedBox(height: 8),

          Text(
            "Alamat : ${restauran.address}",
            style: Theme.of(context).textTheme.bodyMedium,
          ),

          const SizedBox(height: 16),

          Text(restauran.description),
          const SizedBox(height: 24),

          Text("Menu Makanan", style: Theme.of(context).textTheme.titleMedium),
          ...(restauran.menus?.foods ?? []).map(
            (f) => ListTile(
              leading: const Icon(Icons.fastfood),
              title: Text(f.name),
            ),
          ),

          const SizedBox(height: 16),

          Text("Menu Minuman", style: Theme.of(context).textTheme.titleMedium),
          ...(restauran.menus?.drinks ?? []).map(
            (d) => ListTile(
              leading: const Icon(Icons.local_drink),
              title: Text(d.name),
            ),
          ),

          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     Expanded(
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(
          //             restauran.name,
          //             style: Theme.of(context).textTheme.headlineLarge,
          //           ),
          //           Text(
          //             restauran.city,
          //             style: Theme.of(context).textTheme.labelLarge?.copyWith(
          //               fontWeight: FontWeight.w400,
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //     Row(
          //       children: [
          //         Icon(Icons.favorite, color: Colors.pink),
          //         SizedBox.square(dimension: 4),
          //         Text(
          //           restauran.rating.toString(),
          //           style: Theme.of(context).textTheme.bodyLarge,
          //         ),
          //       ],
          //     ),
          //   ],
          // ),
          // SizedBox.square(dimension: 16),
          // Text(
          //   restauran.description,
          //   style: Theme.of(context).textTheme.bodyLarge,
          // ),
        ],
      ),
    );
  }
}
