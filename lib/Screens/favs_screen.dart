import 'package:flutter/material.dart';

import 'package:task1/Models/Api_manager.dart';
import 'package:task1/Models/newsinfo.dart';
import 'package:task1/Screens/Home_screen.dart';

class FavsPage extends StatefulWidget {
  const FavsPage({
    Key? key,
    required this.favid,
  }) : super(key: key);
  final List<dynamic> favid;
  @override
  _FavsPageState createState() => _FavsPageState();
}

class _FavsPageState extends State<FavsPage> {
  late Future<Welcome> _newsModel;
  @override
  void initState() {
    _newsModel = ApiManager().getnews();
    super.initState();
  }

  void addremovenews(id) {
    if (widget.favid.contains(id)) {
      setState(() {
        widget.favid.remove(id);
      });
    } else {
      setState(() {
        widget.favid.add(id);
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
                  return widget.favid.contains(news.id)
                      ? Container(
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
                                widget.favid.contains(news.id)
                                    ? Icons.favorite_rounded
                                    : Icons.favorite_outline_rounded,
                                size: 54,
                                color: widget.favid.contains(news.id)
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
                        )
                      : Container();
                },
              );
            } else
              return Center(child: CircularProgressIndicator());
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 15,
        selectedItemColor: Colors.blue.shade900,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_rounded),
            label: 'Favs',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NewsPage(favid: widget.favid)));
          }
          if (index == 1) {
            Navigator.pop(context);
            Navigator.of(context).pushNamed("/home");
          }
        },
      ),
    );
  }
}
