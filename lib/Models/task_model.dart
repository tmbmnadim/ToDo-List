import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel {
  TaskModel({
    required this.id,
    required this.title,
    required this.details,
    required this.creationTime,
    required this.dueDate,
    required this.pinned,
    required this.isOnline,
    required this.isArchived,
  });

  @HiveField(0)
  late int id;
  @HiveField(1)
  late String title;
  @HiveField(2)
  late String details;
  @HiveField(3)
  late int creationTime;
  @HiveField(4)
  late int dueDate;
  @HiveField(5)
  late bool pinned;
  @HiveField(6)
  late bool isOnline;
  @HiveField(7)
  late bool isArchived;

  TaskModel.fromJson({required Map<String, dynamic> json}) {
    id = json['id'];
    title = json['title'];
    details = json['details'];
    creationTime = json['creationTime'];
    dueDate = json['dueDate'];
    pinned = json['pinned'];
    isOnline = json['isOnline'];
    isArchived = json['isArchived'];
  }

  TaskModel copyWith({
    int? id,
    String? title,
    String? details,
    int? creationTime,
    int? dueDate,
    bool? pinned,
    bool? isOnline,
    bool? isArchived,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      details: details ?? this.details,
      creationTime: creationTime ?? this.creationTime,
      dueDate: dueDate ?? this.dueDate,
      pinned: pinned ?? this.pinned,
      isOnline: isOnline ?? this.isOnline,
      isArchived: isArchived ?? this.isArchived,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'title': title,
        'details': details,
        'creationTime': creationTime,
        'dueDate': dueDate,
        'pinned': pinned,
        'isOnline': isOnline,
        'isArchived': isArchived,
      };
}
