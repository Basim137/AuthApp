class Picture {}

class NotSelectedPicture extends Picture {}

class PictureSelected extends Picture {
  final String path;

  PictureSelected({required this.path});
}

class FailureUploadPicture extends Picture {}

//////////////////////////////////////////////
class FailureDownloadPicture extends Picture {
  final String? errMessage;

  FailureDownloadPicture({this.errMessage});
}

class SuccessPicture extends Picture {
  final String imageDownloadedImg;

  SuccessPicture({required this.imageDownloadedImg});
}
