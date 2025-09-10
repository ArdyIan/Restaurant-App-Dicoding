import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_api_dicoding/data/model/restauran.dart';
import 'package:restaurant_api_dicoding/data/model/restauran_detail_response.dart';
import 'package:restaurant_api_dicoding/provider/detail/bookmark_icon_provider.dart';
import 'package:restaurant_api_dicoding/provider/detail/restauran_detail_provider.dart';
import 'package:restaurant_api_dicoding/screen/detail/body_of_detail_screen_widget.dart';
import 'package:restaurant_api_dicoding/screen/detail/bookmark_icon_widget.dart';
import 'package:restaurant_api_dicoding/static/restauran_detail_result_state.dart';

class DetailScreen extends StatefulWidget {
  final String restauranId;

  const DetailScreen({super.key, required this.restauranId});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
    if (mounted) {
      context.read<RestauranDetailProvider>().fetchRestauranDetail(
        widget.restauranId,
      );
    }
  });
    // Future.microtask(() {
    //   context.read<RestauranDetailProvider>().fetchRestauranDetail(
    //     widget.restauranId,
    //   );
    // });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Restaurant Detail"),
        actions: [
          ChangeNotifierProvider(
            create: (context) => BookmarkIconProvider(),
            child: Consumer<RestauranDetailProvider>(
              builder: (context, value, child) {
                return switch (value.resultState) {
                  RestauranDetailLoadedState(data: var restauran) =>
                    BookmarkIconWidget(restauran: restauran),
                  _ => const SizedBox(),
                };
              },
            ),
          ),
        ],
      ),
      body: Consumer<RestauranDetailProvider>(
        builder: (context, value, child) {
          return switch (value.resultState) {
            RestauranDetailLoadingState() => const Center(
              child: CircularProgressIndicator(),
            ),
            RestauranDetailLoadedState(data: var restauran) =>
              BodyOfDetailScreenWidget(restauran: restauran),
            RestauranDetailErrorState(error: var message) => Center(
              child: Text(message),
            ),
            _ => const SizedBox(),
          };
        },
      ),
    );
  }
}
