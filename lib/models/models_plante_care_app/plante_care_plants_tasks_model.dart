class planteCareTasksModel {
  String? taskId; // Document ID
  String? plantId;
  String? task;
  String? date;
  String? image;
  bool? completed;

  planteCareTasksModel({
    this.taskId,
    this.plantId,
    this.task,
    this.date,
    this.completed,
    this.image,
  });

  planteCareTasksModel.fromJson(Map<String, dynamic> json, {String? docId}) {
    taskId = docId; // Correctly assign the document ID from the parameter
    plantId = json['plantId'];
    task = json['task'];
    date = json['date'];
    completed = json['completed'];
    image = json['image'];
  }


  Map<String, dynamic> toMap() {
    return {
      'taskId': taskId,
      'plantId': plantId,
      'task': task,
      'date': date,
      'completed': completed,
      'image': image,
    };
  }
}
