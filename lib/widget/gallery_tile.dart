import 'package:Fan_Sports/models/gallery_image.dart';
import 'package:flutter/material.dart';

class GalleryTile extends StatelessWidget {
  final GalleryImage image;

  GalleryTile({this.image});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.network(image.imageUrl),
          Container(
            padding: EdgeInsets.all(10),
            child: Text(image.description + "@" ),//+ image.tournamentTag.tournamentName
          )
        ],
      ),
    );
  }
}
