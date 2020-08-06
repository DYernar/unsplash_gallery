import 'package:equatable/equatable.dart';

abstract class ImageEvent extends Equatable {}

class LoadImagesEvent extends ImageEvent {
  @override
  List<Object> get props => [];
}
