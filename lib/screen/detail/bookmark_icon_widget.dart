import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_api_dicoding/data/model/restauran.dart';
import 'package:restaurant_api_dicoding/provider/detail/bookmark_list_provider.dart';
import 'package:restaurant_api_dicoding/provider/detail/bookmark_icon_provider.dart';

class BookmarkIconWidget extends StatefulWidget {
  final Restauran restauran;
  const BookmarkIconWidget({super.key, required this.restauran});

  @override
  State<BookmarkIconWidget> createState() => _BookmarkIconWidgetState();
}

class _BookmarkIconWidgetState extends State<BookmarkIconWidget> {
  @override
  void initState() {
    final bookmarkListProvider = context.read<BookmarkListProvider>();
    final bookmarkIconProvider = context.read<BookmarkIconProvider>();

    Future.microtask(() {
      final restauranInList = bookmarkListProvider.checkItemBookmark(
        widget.restauran,
      );
      bookmarkIconProvider.isBookmarked = restauranInList;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        final bookmarkListProvider = context.read<BookmarkListProvider>();
        final bookmarkIconProvider = context.read<BookmarkIconProvider>();
        final isBookmarked = bookmarkIconProvider.isBookmarked;

        if (isBookmarked) {
          bookmarkListProvider.removeBookmark(widget.restauran);
        } else {
          bookmarkListProvider.addBookmark(widget.restauran);
        }
        context.read<BookmarkIconProvider>().isBookmarked = !isBookmarked;
      },

      icon: Icon(
        context.watch<BookmarkIconProvider>().isBookmarked
            ? Icons.bookmark
            : Icons.bookmark_outline,
      ),
    );
  }
}
