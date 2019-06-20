import 'package:Fan_Sports/models/gallery_image.dart';
import 'package:flutter/material.dart';

class GalleryTile extends StatelessWidget {
  final GalleryImage image;

  GalleryTile({this.image});
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Image(
            image: NetworkImage(image.imageUrl),
            fit: BoxFit.fitWidth,
          ),
          Container(
            padding: EdgeInsets.only(top: 20.0,left: 20.0),
            child: Text(
                "Date : "+image.description + "@",textScaleFactor: 1.1,), //+ image.tournamentTag.tournamentName
          ),
          Container(
            padding: EdgeInsets.only(top: 5,left: 20.0,bottom: 20.0),
            child: Text(
               "Description" + image.description + "@",textScaleFactor: 1.1,), //+ image.tournamentTag.tournamentName
          )
        ],
      ),
    );
  }
}
