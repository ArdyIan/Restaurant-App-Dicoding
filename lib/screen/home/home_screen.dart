import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_api_dicoding/data/model/restauran.dart';
import 'package:restaurant_api_dicoding/data/model/restauran_list_response.dart';
import 'package:restaurant_api_dicoding/provider/home/restauran_list_provider.dart';
import 'package:restaurant_api_dicoding/screen/home/restauran_card_widget.dart';
import 'package:restaurant_api_dicoding/static/navigation_route.dart';
import 'package:restaurant_api_dicoding/static/restauran_list_result_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<RestauranListProvider>().fetchRestauranList();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Restaurant LIst")),
      body: Consumer<RestauranListProvider>(
        builder: (context, value, child) {
          return switch (value.resultState) {
            RestauranListLoadingState() => const Center(
              child: CircularProgressIndicator(),
            ),
            RestauranListLoadedState(data: var restauranList) =>
              ListView.builder(
                itemCount: restauranList.length,
                itemBuilder: (context, index) {
                  final restauran = restauranList[index];

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
            RestauranListErrorState(error: var message) => Center(
              child: Text(message),
            ),
            _ => const SizedBox(),
          };
        },
      ),
    );
  }
}
