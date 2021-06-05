import 'package:flutter/material.dart';

import 'package:task1/Models/Api_manager.dart';
import 'package:task1/Models/newsinfo.dart';
import 'package:task1/Screens/favs_screen.dart';

class NewsPage extends StatefulWidget {
  final List<dynamic> favid;
  const NewsPage({
    Key? key,
    required this.favid,
  }) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late Future<Welcome> _newsModel;
  List<dynamic> favids = [];
  @override
  void initState() {
    favids = widget.favid;
    _newsModel = ApiManager().getnews();
    super.initState();
  }

  void addremovenews(id) {
    if (favids.contains(id)) {
      setState(() {
        favids.remove(id);
      });
    } else {
      setState(() {
        favids.add(id);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder<Welcome>(
          future: _newsModel,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.data!.length,
                itemBuilder: (context, index) {
                  var news = snapshot.data!.data![index];
                  return Container(
                    padding: const EdgeInsets.all(5.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 3,
                      child: ListTile(
                        onTap: () {
                          addremovenews(news.id);
                        },
                        contentPadding: const EdgeInsets.all(5.0),
                        leading: Icon(
                          favids.contains(news.id)
                              ? Icons.favorite_rounded
                              : Icons.favorite_outline_rounded,
                          size: 54,
                          color: favids.contains(news.id)
                              ? Colors.red
                              : Colors.grey,
                        ),
                        title: Text(
                          news.title.toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              news.summary.toString(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              news.published.toString(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else
              return Center(child: CircularProgressIndicator());
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 15,
        selectedItemColor: Colors.blue.shade900,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline_rounded),
            label: 'Favs',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.pop(context);
            Navigator.pushNamed(context, "/");
          }
          if (index == 1) {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FavsPage(favid: favids)));
          }
        },
      ),
    );
  }
}
