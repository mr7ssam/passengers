import 'package:p_core/p_core.dart';
import 'package:p_network/p_http_client.dart';
import 'package:reactive_image_picker/image_file.dart';
import 'package:shop_app/app/category/domain/entities/tag.dart';

class AddProductParams extends FormDataParams {
  AddProductParams({
    required this.name,
    required this.image,
    required this.price,
    required this.description,
    required this.tag,
    required this.prepareTime,
  });

  final String name;
  final ImageFile image;
  final String description;
  final Tag tag;
  final double price;
  final Duration prepareTime;

  @override
  Future<FormData> toFromData() async {
    return FormData.fromMap(
      toMap()
        ..addAll(
          {
            if (image.image != null)
              'imageFile': MultipartFile.fromFileSync(
                (await compressImage(image.image!))!.path,
              )
          },
        ),
    );
  }

  UpdateProductParams update(String id) {
    return UpdateProductParams(
      id: id,
      price: price,
      prepareTime: prepareTime,
      name: name,
      image: image,
      description: description,
      tag: tag,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'tagId': tag.id,
      'prepareTime': prepareTime.inSeconds,
      'price': price.toInt(),
    };
  }

  factory AddProductParams.fromMap(Map<String, dynamic> map) {
    return AddProductParams(
      name: map['name'],
      image: map['image'],
      description: map['description'],
      tag: map['tag'],
      prepareTime: map['prepareTime'],
      price: (map['price'] as int).toDouble(),
    );
  }
}

class UpdateProductParams extends AddProductParams {
  final String id;

  UpdateProductParams({
    required this.id,
    required String name,
    required ImageFile image,
    required String description,
    required Tag tag,
    required double price,
    required Duration prepareTime,
  }) : super(
          tag: tag,
          description: description,
          image: image,
          name: name,
          prepareTime: prepareTime,
          price: price,
        );

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()..addAll({'id': id});
  }
}
