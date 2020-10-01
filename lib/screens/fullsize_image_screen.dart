import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class FullSizeImageScreen extends StatefulWidget {
  final String fullImageURL;

  FullSizeImageScreen({this.fullImageURL});

  @override
  _FullSizeImageScreenState createState() => _FullSizeImageScreenState();
}

class _FullSizeImageScreenState extends State<FullSizeImageScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        child: Image(
          image: NetworkImage(widget.fullImageURL),
          fit: BoxFit.fitWidth,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: SpinKitCircle(
                color: Colors.grey,
                size: 100,
              ),
            );
          },
        ),
      ),
    );
  }
}
