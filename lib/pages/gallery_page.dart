import "package:flutter/material.dart";
import 'package:scoped_model/scoped_model.dart';

import '../widget/drawer.dart';
import '../models/gallery_image.dart';
import '../widget/gallery_tile.dart';
import '../scoped_model/main.dart';

class GalleryPage extends StatefulWidget {
  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  List<GalleryImage> array = [];

  @override
  void initState() {
    getImages();
    super.initState();
  }

  void getImages() {}
  @override
  Widget build(BuildContext context) {
    MainModel model = ScopedModel.of(context);
    print("REACHING 1");
    if (array.length == 0) {
      model.loadGalleryImages(model.token).then((success) {
        print(success);
        if (success) {
          print("REACHING 2");
          setState(() {
            array = model.galleryImages;
          });
        }
      });
    }
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text("Gallery"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: array.length == 0
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: array.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: GalleryTile(image: array[index]),
                );
              },
            ),
    );
  }
}
