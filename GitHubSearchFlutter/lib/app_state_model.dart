import 'dart:convert';

import 'package:flutter/foundation.dart' as foundation;
import 'package:http/http.dart' as http;

import 'model/github_repository.dart';

class AppStateModel extends foundation.ChangeNotifier {
  List<GitHubRepository> searchResults = [];

  void search(String keyword) async {
    print('search executed. keyword = $keyword');
    final response = await http.get(
        'https://api.github.com/search/repositories?q=${keyword.toLowerCase()}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      final List<dynamic> repositories = json['items'];
      searchResults =
          repositories.map((j) => GitHubRepository.fromJson(j)).toList();

      notifyListeners();
    } else {
      throw Exception('Failed to search repository');
    }
  }
}
