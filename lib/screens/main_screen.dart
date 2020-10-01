import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:test_app/components/list_photo_item.dart';
import 'package:test_app/services/photo_service.dart';
import 'package:test_app/widgets/image_card.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int pageIndex = 1;
  List<ListPhotoItem> photosList = [];
  ScrollController controller;
  PhotoService photoService = PhotoService();

  Future<void> getPhotos() async {
    List<ListPhotoItem> newPhotosList =
        await photoService.getPhotoDataPerPage(pageIndex);
    setState(() {
      for (int i = 0; i < newPhotosList.length; i++) {
        photosList.add(newPhotosList[i]);
      }
    });
  }

  void scrollListener() {
    if (controller.offset >= controller.position.maxScrollExtent) {
      pageIndex++;
      getPhotos();
    }
  }

  @override
  void initState() {
    controller = ScrollController();
    controller.addListener(scrollListener);
    getPhotos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: photosList.isNotEmpty
          ? GridView.count(
              controller: controller,
              crossAxisCount: 2,
              children: List.generate(photosList.length, (int index) {
                return ImageCard(
                  listImageItem: photosList.elementAt(index),
                );
              }),
            )
          : SpinKitCircle(
              color: Colors.grey,
            ),
    );
  }
}
