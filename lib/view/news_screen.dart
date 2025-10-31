import 'package:flutter/material.dart';
import 'package:news_app/controller/provider/news_data_provider.dart';
import 'package:news_app/model/news_model.dart';
import 'package:news_app/view/selected_news_screen.dart';
import 'package:news_app/widgets/loading_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  fetchNewsData() {
    Provider.of<NewsDataProvider>(context, listen: false).fetchNewsApi();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchNewsData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Top headlines',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Consumer<NewsDataProvider>(
        builder: (context, newsProvider, child) {
          if (newsProvider.news.isEmpty) {
            return LoadingWidget();
          } else {
            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
              itemCount: newsProvider.news.length,
              itemBuilder: (context, index) {
                NewsModel currentNewsItem = newsProvider.news[index];
                return InkWell(
                  onTap: () {
                    Provider.of<NewsDataProvider>(
                      context,
                      listen: false,
                    ).updateSelectedNews(currentNewsItem);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelectedNewsScreen(),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 2.w,
                      vertical: 1.h,
                    ),
                    margin: EdgeInsets.symmetric(vertical: 1.h),
                    height: 30.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          height: 18.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image:
                                currentNewsItem.newsImageUrl != null &&
                                        currentNewsItem.newsImageUrl!.isNotEmpty
                                    ? DecorationImage(
                                      image: NetworkImage(
                                        currentNewsItem.newsImageUrl!,
                                      ),
                                      fit: BoxFit.cover,
                                    )
                                    : null,
                          ),
                        ),
                        Text(
                          currentNewsItem.title!,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          currentNewsItem.author ?? 'Unknown Author',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
