import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prac_27/core/api/constants.dart';
import 'package:prac_27/cubits/picture/picture_state.dart';

class PicCubit extends Cubit<Picture> {
  XFile? image;

  PicCubit(super.initialState);

  selectGalleryImage() async {
    image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      if (((await image!.length()) / 1024 >= 5 * 1024) ||
          extension(image!.path) != '.jpg' &&
              extension(image!.path) != '.jpeg') {
        emit(FailureUploadPicture());
      } else {
        emit(PictureSelected(path: image!.path));
      }
    } else {
      emit(NotSelectedPicture());
    }
  }

  selectCameraImage() async {
    image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      if ((await image!.length()) / 1024 > 5 * 1024 ||
          extension(image!.path) != '.jpg' &&
              extension(image!.path) != '.jpeg') {
        emit(FailureUploadPicture());
      } else {
        emit(PictureSelected(path: image!.path));
      }
    } else {
      emit(NotSelectedPicture());
    }
  }

  dowloadImage({required String path}) async {
    final directory = await getApplicationDocumentsDirectory();
    String fileName = path.split('/').last;
    String filePath = '${directory.path}/$fileName';
    final box = Hive.box(AppKeys.infoHive);

    try {
      await Dio().download(path, filePath);

      if (!isClosed) {
        emit(SuccessPicture(imageDownloadedImg: filePath));
        box.put(AppKeys.image, filePath);
      }
    } catch (e) {
      if (!isClosed) {
        emit(FailureDownloadPicture(errMessage: 'فشل في تحميل الصورة'));
      }
    }
  }
}
