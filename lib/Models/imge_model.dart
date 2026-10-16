class imgeModel {
  String? imgePath;
  String? tiltle;
  String? subTitle;
  String? author;

  imgeModel({this.imgePath, this.tiltle, this.subTitle, this.author});

  imgeModel.fromJson(Map<String, dynamic> json) {
    imgePath = json['imgePath'];
    tiltle = json['tiltle'];
    subTitle = json['subTitle'];
    author = json['author'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imgePath'] = imgePath;
    data['tiltle'] = tiltle;
    data['subTitle'] = subTitle;
    data['author'] = author;
    return data;
  }
}
