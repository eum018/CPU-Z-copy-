class SensorModel {
  final int id;
  final String name;
  final String type;
  final Map<String, dynamic> content;

  SensorModel({
    required this.id,
    required this.name,
    required this.type,
    required this.content,
  });

  static SensorModel fromJson(Map json) {
    return SensorModel(
      id: json['id'],
      name: json['name'],
      type: json['sensor_type'],
      content: (json['content'] as Map).map((key, value) => MapEntry(key.toString(), value),),
    );
  }
}
