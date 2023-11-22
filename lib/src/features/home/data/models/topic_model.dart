import 'package:chat_rooms/src/features/home/domain/entities/topic.dart';

class TopicModel extends Topic {
  const TopicModel({super.topic, super.topicId});

  factory TopicModel.fromMap(Map<String, dynamic> map, String? topicId) {
    return TopicModel(
      topic: map['topic'] ?? '',
      topicId: topicId ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {'topic': topic};
  }
}
