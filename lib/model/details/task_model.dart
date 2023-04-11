class TaskModel {
  String? sId;
  String? name;
  String? description;
  String? dueDate;
  String? priority;
  String? status;
  String? createdDate;

  TaskModel({
    this.sId,
    this.name,
    this.description,
    this.dueDate,
    this.priority,
    this.status,
    this.createdDate,
  });

  TaskModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    dueDate = json['dueDate'];
    priority = json['priority'];
    status = json['status'];
    createdDate = json['createdDate'];
  }

  Map<String, String?> toJson() {
    return <String, String?>{
      '_id': sId,
      'name': name,
      'description': description,
      'dueDate': dueDate,
      'priority': priority,
      'status': status,
      'createdDate': createdDate,
    };
  }
}
