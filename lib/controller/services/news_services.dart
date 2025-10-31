import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:news_app/controller/services/api_and_headers.dart';

class NewsServices {
  static getNews() async {
    try {
      http.Response response = await http
          .get(Uri.parse(newsAPI), headers: header)
          .timeout(
            const Duration(seconds: 60),
            onTimeout: () {
              log('Connection Timed Out');
              throw Exception('Connection Timed Out');
            },
          );
      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body);
        List<dynamic> newsData = decodedResponse['articles'] as List<dynamic>;
        return newsData;
      }
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }
}
