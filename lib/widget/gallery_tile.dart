import 'package:Fan_Sports/models/gallery_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../pages/gallery_image_details.dart';

class GalleryTile extends StatelessWidget {
  final GalleryImage image;

  GalleryTile({this.image});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 350.0,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    image: DecorationImage(
                        fit: BoxFit.fill, image: NetworkImage(image.imageUrl)),
                  ),
                ),
                Container(
                  height: 350.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.black.withOpacity(0.05)
                      ],
                      stops: [0.0, 0.4],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 20.0, left: 15.0),
                  child: Text(
                    image.tournamentTag.tournamentName,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.only(top: 20.0, left: 20.0),
              child: Text(
                "Date : " +
                    DateFormat.yMMMMd("en_US")
                        .format(image.tournamentTag.date)
                        .toString(),
                textScaleFactor: 1.1,
              ), //+ image.tournamentTag.tournamentName
            ),
            Container(
              padding: EdgeInsets.only(top: 5, left: 20.0, bottom: 20.0),
              child: Text(
                "Description " + image.description,
                textScaleFactor: 1.1,
              ), //+ image.tournamentTag.tournamentName
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return GalleryImageDetailsPage(image);
        }));
      },
    );
  }
}
