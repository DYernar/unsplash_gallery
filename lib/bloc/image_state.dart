import 'package:equatable/equatable.dart';

abstract class ImageState extends Equatable {}

class LoadingImageState extends ImageState {
  @override
  List<Object> get props => [];
}

class ShowImagesState extends ImageState {
  final List<Map> images;

  ShowImagesState(this.images);
  @override
  List<Object> get props => [images];
}

class FailureState extends ImageState {
  @override
  List<Object> get props => [];
}
