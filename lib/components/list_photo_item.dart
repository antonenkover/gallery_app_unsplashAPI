class ListPhotoItem {
  final String previewImageURL;
  final String fullImageURL;
  final String authorName;

  ListPhotoItem({this.previewImageURL, this.fullImageURL, this.authorName});

  String getPreviewImageURL() {
    return previewImageURL;
  }

  String getFullImageURL() {
    return fullImageURL;
  }

  String getAuthorName() {
    return authorName;
  }
}
