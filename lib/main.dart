import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_api_dicoding/data/api/api_service.dart';
import 'package:restaurant_api_dicoding/data/model/restauran_list_response.dart';
import 'package:restaurant_api_dicoding/data/model/restauran_detail_response.dart';
import 'package:restaurant_api_dicoding/provider/detail/bookmark_list_provider.dart';
import 'package:restaurant_api_dicoding/provider/detail/restauran_detail_provider.dart';
import 'package:restaurant_api_dicoding/provider/home/restauran_list_provider.dart';
import 'package:restaurant_api_dicoding/provider/main/index_nav_provider.dart';
import 'package:restaurant_api_dicoding/screen/detail/detail_screen.dart';
import 'package:restaurant_api_dicoding/screen/main/main_screen.dart';
import 'package:restaurant_api_dicoding/static/navigation_route.dart';

void main() {
  final ApiServices apiServices = ApiServices();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => IndexNavProvider()),
        ChangeNotifierProvider(create: (context) => BookmarkListProvider()),
        Provider(create: (context) => ApiServices()),
        ChangeNotifierProvider(
          create: (_) => RestauranListProvider(apiServices),
          // create: (context) =>
          // RestauranListProvider(context.read<ApiServices>()),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              RestauranDetailProvider(context.read<ApiServices>()),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      //  theme: RestauranTheme.lightTheme,
      //  theme: RestauranTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: NavigationRoute.mainRoute.name,
      routes: {
        NavigationRoute.mainRoute.name: (context) => const MainScreen(),
        NavigationRoute.detailRoute.name: (context) => DetailScreen(
          restauranId: ModalRoute.of(context)?.settings.arguments as String,
        ),
      },
    );
  }
}
