class CompleteInfoDTO {
  final String categoryName;
  final String imagePath;

  CompleteInfoDTO({
    required this.categoryName,
    required this.imagePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'categoryName': categoryName,
      'imagePath': imagePath,
    };
  }

  factory CompleteInfoDTO.fromMap(Map<String, dynamic> map) {
    return CompleteInfoDTO(
      categoryName: map['categoryName'] as String,
      imagePath: map['imagePath'] as String,
    );
  }
}
