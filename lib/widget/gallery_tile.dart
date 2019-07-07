import 'package:Fan_Sports/models/gallery_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import '../pages/player_profile_page.dart';
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
                      fit: BoxFit.fitHeight,
                      image: NetworkImage(image.imageUrl),
                    ),
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
                  height: 350.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: FractionalOffset.bottomCenter,
                      end: FractionalOffset.center,
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.black.withOpacity(0.05)
                      ],
                      stops: [
                        0.0,
                        1,
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 20.0, left: 15.0),
                  child: Text(
                    image.tournamentName,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 300.0, left: 15.0),
                  child: Text(
                    image.description,
                    maxLines: 2,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(top: 10.0, left: 20.0, bottom: 5),
              child: Text(
                DateFormat.yMMMMd("en_US")
                        .format(image.tournamentDate)
                        .toString() +
                    " - " +
                    image.tournammentVenue,
                textScaleFactor: 1,
                style: TextStyle(fontSize: 14),
              ), //+ image.tournamentTag.tournamentName
            ),
            Container(
              padding: EdgeInsets.only(left: 20.0, bottom: 10),
              child: Text(
                "Tagged Users : " + image.taggedUserList.length.toString(),
                textScaleFactor: 1,
                style: TextStyle(fontSize: 14),
              ),
            ),
            GridView.builder(
              controller: ScrollController(keepScrollOffset: true),
              shrinkWrap: true,

              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 4, crossAxisCount: 3
                  // crossAxisSpacing: 60,
                  ),
              // scrollDirection: Axis.vertical,
              itemCount: image.taggedUserList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  child: Container(
                    // height: 30,
                    alignment: Alignment(0, 0),
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    child: Text(
                      image.taggedUserList[index].name,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return PlayerProfilePage(image.taggedUserList[index]);
                    }));
                  },
                );
              },
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                child: Image.network(image.imageUrl),
              );
            });

        // Navigator.push(context, MaterialPageRoute(builder: (context) {
        //   return GalleryImageDetailsPage(image);
        // }));
      },
    );
  }
}
