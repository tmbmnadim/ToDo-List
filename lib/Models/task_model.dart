import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel {
  TaskModel({
    required this.title,
    required this.details,
    required this.creationTime,
    required this.dueDate,
    required this.pinned,
    required this.isOnline,
  });

  @HiveField(0)
  late String title;
  @HiveField(1)
  late String details;
  @HiveField(2)
  late int creationTime;
  @HiveField(3)
  late int dueDate;
  @HiveField(4)
  late bool pinned;
  @HiveField(5)
  late bool isOnline;

  TaskModel.fromJson({required Map<String, dynamic> json}) {
    title = json['title'];
    details = json['details'];
    creationTime = json['creationTime'];
    dueDate = json['dueDate'];
    pinned = json['pinned'];
    isOnline = json['isOnline'];
  }

  TaskModel copyWith({
    String? title,
    String? details,
    int? creationTime,
    int? dueDate,
    bool? pinned,
    bool? isOnline,
  }) {
    return TaskModel(
      title: title ?? this.title,
      details: details ?? this.details,
      creationTime: creationTime ?? this.creationTime,
      dueDate: dueDate ?? this.dueDate,
      pinned: pinned ?? this.pinned,
      isOnline: isOnline ?? this.isOnline,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'title': title,
        'details': details,
        'creationTime': creationTime,
        'dueDate': dueDate,
        'pinned': pinned,
        'isOnline': isOnline,
      };
}
