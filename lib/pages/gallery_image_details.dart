import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'player_profile_page.dart';
import '../models/gallery_image.dart';

class GalleryImageDetailsPage extends StatelessWidget {
  GalleryImage image;
  GalleryImageDetailsPage(this.image);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          expandedHeight: 350.0,
          forceElevated: true,
          title: Text(image.tournamentTag.tournamentName),
          flexibleSpace: FlexibleSpaceBar(
            background: Image(
              image: NetworkImage(image.imageUrl),
              fit: BoxFit.fill,
            ),
          ),
        ),
        SliverFixedExtentList(
          itemExtent: MediaQuery.of(context).size.height,
          delegate: SliverChildListDelegate(
            [
              Scaffold(
                body: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10.0),
                        child: Text("Tournament : " +
                            image.tournamentTag.tournamentName),
                      ),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        child: Text("Description : " + image.description),
                      ),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        child: Text("Venue : " + image.tournamentTag.venue),
                      ),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        child: Text("Date : " +
                            DateFormat.yMMMMd()
                                .format(image.tournamentTag.date)),
                      ),
                      Container(
                          padding: EdgeInsets.only(left:10.0,top: 10.0),
                          child: Text("Tagged Users")),
                      ListView.builder(
                        controller: ScrollController(keepScrollOffset: true),
                        shrinkWrap: true,
                        itemCount: image.taggedUserList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            child: Container(
                              padding: EdgeInsets.only(bottom: 10.0,left: 10.0),
                              child: Text(
                                image.taggedUserList[index].name,
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return PlayerProfilePage(
                                    image.taggedUserList[index]);
                              }));
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
