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

  Map<String, dynamic> toJson() => <String, dynamic>{
        'title': title,
        'details': details,
        'creationTime': creationTime,
        'dueDate': dueDate,
        'pinned': pinned,
        'isOnline': isOnline,
      };
}
