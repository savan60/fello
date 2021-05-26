import 'package:fello/news.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class P_News with ChangeNotifier {
  List<M_News> newslist = [];
  int page = 1;
  String urlfront =
      'https://newsapi.org/v2/everything?q=Apple&from=2021-05-25&sortBy=popularity&apiKey=c5bfa174f5ab4672bac3b3c3531d86e3';

  void refresh() {
    newslist = [];
    notifyListeners();
  }

  Future<void> fetchnews(int flag) async {
    String url;
    if (flag == 0) {
      newslist = [];
      page = 1;
    }
    if (page == -1) {
      return;
    }
    url = urlfront + '&page=$page';
    page = page + 1;
    print("page becoms $page");

    print("url is ${url}");
    try {
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
        },
      );
      final res = json.decode(response.body);
      if (response.statusCode < 300 && response.statusCode >= 200) {
        var list = res['articles'] as List;
        list.forEach((element) {
          newslist.add(
            M_News(
              description: element['description'],
              image: element['urlToImage'],
              title: element['title'],
            ),
          );
        });
        notifyListeners();
      } else {
        page = -1;
      }
    } catch (error) {
      print("error occured in catch");
    }
  }
}
