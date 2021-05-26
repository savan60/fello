import 'package:fello/p_news.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  ScrollController _scrollController = new ScrollController();
  bool isinitial = true;
  bool isloading = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("hereeeee");
    if (isinitial) {
      setState(() {
        isloading = true;
      });
      Provider.of<P_News>(context, listen: false).fetchnews(0).then((value) {
        setState(() {
          isloading = false;
        });
      }).catchError((onError) {
        print("error occured");
        setState(() {
          isloading = false;
        });
      });
    }
    isinitial = false;
  }

  Future<void> _getdata() async {
    setState(() {
      isloading = true;
    });

    Provider.of<P_News>(context,listen: false).refresh();
    Provider.of<P_News>(context, listen: false).fetchnews(0).then((value) {
      setState(() {
        isloading = false;
      });
    }).catchError((onerror) {
      setState(() {
        isloading = false;
        // iserror = true;
      });
    });
  }

  void initState() {
    // TODO: implement initState
    print("shoplistmain inistate before");

    super.initState();
    print("initstate of Shoplistmain");

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          isloading = true;
        });
        try {
          Provider.of<P_News>(context, listen: false)
              .fetchnews(1)
              .then((value) {
            setState(() {
              isloading = false;
            });
          });
        } catch (error) {
          setState(() {
            isloading = false;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recent News"),
      ),
      body: Consumer<P_News>(builder: (context, news, _) {
        return Container(
          padding: EdgeInsets.only(top: 8),
          child: RefreshIndicator(
            onRefresh: _getdata,
            child: ListView.builder(
              controller: _scrollController,
              itemBuilder: (context, index) {
                return index == news.newslist.length
                    ? isloading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Container()
                    : Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        height: 90,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 80,
                                padding: EdgeInsets.only(right: 4),
                                // color: Colors.orange,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4.0),
                                  child: Image.network(
                                    news.newslist[index].image ??
                                        "https://image.shutterstock.com/image-vector/news-anchor-on-tv-breaking-260nw-442698565.jpg",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        news.newslist[index].title??"Title not available",
                                        maxLines: 2,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Flexible(
                                      child: Text(
                                        news.newslist[index].description??"Description not available",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                )
                                
                                ),
                          ],
                        ),
                      );
              },
              itemCount: news.newslist.length + 1,
            ),
          ),
        );
      }),
    );
  }
}
