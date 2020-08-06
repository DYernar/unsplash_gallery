import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:unsplash_gallery/bloc/image_bloc.dart';
import 'package:unsplash_gallery/bloc/image_event.dart';
import 'package:unsplash_gallery/bloc/image_state.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:unsplash_gallery/photo_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ImageBloc _imageBloc;

  @override
  void initState() {
    super.initState();
    _imageBloc = ImageBloc();
    _imageBloc.add(LoadImagesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _imageBloc,
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: BlocBuilder<ImageBloc, ImageState>(builder: (context, state) {
            if (state is LoadingImageState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is FailureState) {
              return Center(
                child: Text('something went wrong'),
              );
            }
            if (state is ShowImagesState) {
              return Container(
                child: new StaggeredGridView.countBuilder(
                  crossAxisCount: 4,
                  itemCount: state.images.length,
                  itemBuilder: (BuildContext context, int index) =>
                      GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              ImagePage(state.images[index]),
                        ),
                      );
                    },
                    child: Stack(
                      children: <Widget>[
                        new Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 5.0,
                                color: Colors.grey[400],
                              )
                            ],
                            image: DecorationImage(
                              image: NetworkImage(state.images[index]['url']),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Container(),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.black.withOpacity(0.4),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  '${state.images[index]['title']}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.9),
                                    fontWeight: FontWeight.w300,
                                    fontSize: 16.0,
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.photo_camera,
                                      color: Colors.white,
                                      size: 14.0,
                                    ),
                                    Text(
                                      '${state.images[index]['author']}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  staggeredTileBuilder: (int index) =>
                      new StaggeredTile.count(2, index.isEven ? 3 : 3),
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                ),
              );
            }
            return Container();
          }),
        ),
      ),
    );
  }
}
