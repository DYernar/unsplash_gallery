import 'package:flutter/material.dart';

class ImagePage extends StatelessWidget {
  final Map image;
  const ImagePage(this.image);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.network(
              image['fullImg'],
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
    );
  }
}
