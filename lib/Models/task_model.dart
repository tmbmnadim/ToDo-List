class TaskModel {
  TaskModel({
    required this.title,
    required this.details,
    required this.creationTime,
    required this.dueDate,
    required this.pinned,
    required this.isOnline,
  });

  late String title;
  late String details;
  late String creationTime;
  late String dueDate;
  late bool pinned;
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
    String? creationTime,
    String? dueDate,
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
