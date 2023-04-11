class TaskModel {
  String? sId;
  String? name;
  String? description;
  String? dueDate;
  String? developer;
  String? status;
  String? createdDate;

  TaskModel({
    this.sId,
    this.name,
    this.description,
    this.dueDate,
    this.developer,
    this.status,
    this.createdDate,
  });

  TaskModel.fromJson(Map<String, dynamic> json) {
    sId = json['id'];
    name = json['name'];
    description = json['description'];
    dueDate = json['dueDate'];
    developer = json['developer'];
    status = json['status'];
    createdDate = json['createdDate'];
  }

  Map<String, String?> toJson() {
    return <String, String?>{
      'id': sId,
      'name': name,
      'description': description,
      'dueDate': dueDate,
      'developer': developer,
      'status': status,
      'createdDate': createdDate,
    };
  }
}
