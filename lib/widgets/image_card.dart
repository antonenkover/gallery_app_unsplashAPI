import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:test_app/components/list_photo_item.dart';
import 'package:test_app/screens/fullsize_image_screen.dart';

class MyCustomRoute<T> extends MaterialPageRoute<T> {
  MyCustomRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return new ScaleTransition(
      scale: animation,
      child: new FadeTransition(opacity: animation, child: child),
    );
  }
}

class ImageCard extends StatelessWidget {
  final ListPhotoItem listImageItem;

  ImageCard({this.listImageItem});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          new MyCustomRoute(
            builder: (context) => FullSizeImageScreen(
              fullImageURL: listImageItem.getFullImageURL(),
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Container(
          padding: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[200],
            boxShadow: [
              BoxShadow(
                color: Colors.grey[500],
                blurRadius: 3.0,
                spreadRadius: 1.0,
                offset: Offset(2.0, 2.0),
              )
            ],
          ),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Image.network(
                  listImageItem.getPreviewImageURL(),
                  fit: BoxFit.fill,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: SpinKitCircle(
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    'by: ${listImageItem.getAuthorName().toLowerCase()}',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
