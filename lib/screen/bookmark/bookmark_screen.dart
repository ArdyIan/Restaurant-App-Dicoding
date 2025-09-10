import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_api_dicoding/provider/detail/bookmark_list_provider.dart';
import 'package:restaurant_api_dicoding/screen/home/restauran_card_widget.dart';
import 'package:restaurant_api_dicoding/static/navigation_route.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bookmark List")),
      body: Consumer<BookmarkListProvider>(
        builder: (context, value, child) {
          final bookmarkList = value.bookmarkList;
          return switch (bookmarkList.isNotEmpty) {
            true => ListView.builder(
              itemCount: bookmarkList.length,
              itemBuilder: (context, index) {
                final restauran = bookmarkList[index];
                return RestauranCard(
                  restauran: restauran,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      NavigationRoute.detailRoute.name,
                      arguments: restauran.id,
                    );
                  },
                );
              },
            ),
            _ => const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("No Bookmarked Item")],
              ),
            ),
          };
        },
      ),
    );
  }
}
