import 'package:flutter/material.dart';

class MySearchDelegete extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            if (query == '') {
              close(context, null);
            } else {
              query = '';
            }
          },
          icon: const Icon(Icons.close)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back),
      iconSize: 50,
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
    // here we will display search results
  }

  @override
  Widget buildSuggestions(BuildContext context) => Container();
  // here we will display suggestions for search if we have one
  // https://youtu.be/Xinjf7AQUYA here is how to do it
}
