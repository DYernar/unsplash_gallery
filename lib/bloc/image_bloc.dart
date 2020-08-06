import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unsplash_gallery/bloc/image_event.dart';
import 'package:unsplash_gallery/bloc/image_state.dart';
import 'package:http/http.dart' as http;

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  List<Map> images = [];
  ImageBloc() : super(null);

  @override
  Stream<ImageState> mapEventToState(ImageEvent event) async* {
    if (event is LoadImagesEvent) {
      yield LoadingImageState();
      await _getImages();
      if (images == null || images.length == 0) {
        yield FailureState();
      }
      yield ShowImagesState(images);
    }
  }

  Future<void> _getImages() async {
    String url =
        'https://api.unsplash.com/photos?client_id=cf49c08b444ff4cb9e4d126b7e9f7513ba1ee58de7906e4360afc1a33d1bf4c0';
    try {
      var response = await http.get(url);
      var data = jsonDecode(response.body);

      data.forEach(
        (element) {
          Map obj = {
            'author': element['user']['name'],
            'title': element['alt_description'],
            'url': element['urls']['small'],
            'fullImg': element['urls']['regular']
          };
          images.add(obj);
        },
      );
      print(images.length);
    } catch (e) {
      print('Error : $e');
    }
  }
}
