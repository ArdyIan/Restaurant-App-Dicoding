import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_api_dicoding/provider/favorite/favorite_provider.dart';
import 'package:restaurant_api_dicoding/screen/detail/detail_screen.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Favorite Restaurants")),
      body: Consumer<FavoriteProvider>(
        builder: (context, favProvider, child) {
          if (favProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (favProvider.favorites.isEmpty) {
            return const Center(child: Text("Belum ada restoran favorit"));
          }

          return ListView.builder(
            itemCount: favProvider.favorites.length,
            itemBuilder: (context, index) {
              final restauran = favProvider.favorites[index];
              return ListTile(
                title: Text(restauran.name),
                subtitle: Text(restauran.city),
                leading: Image.network(restauran.pictureId, width: 60),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailScreen(restauranId: restauran.id),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
