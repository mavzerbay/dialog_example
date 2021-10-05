import 'package:json_annotation/json_annotation.dart';

import '../../../core/base/model/abstracts/base_model.dart';

part 'post_model.g.dart';

@JsonSerializable()
class PostModel extends BaseModel<PostModel> {
  int? userId;
  int? id;
  String? title;
  String? body;
  
  PostModel({
    this.userId,
    this.id,
    this.title,
    this.body,
  });


  @override
  PostModel fromJson(Map<String, dynamic> json) {
    return _$PostModelFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$PostModelToJson(this);
  }

  
}
