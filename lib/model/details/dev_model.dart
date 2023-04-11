class TaskDeveloper {
  String? sId;
  String? name;
  String? category;

  TaskDeveloper({
    this.sId,
    this.name,
    this.category,
  });

  TaskDeveloper.fromJson(Map<String, dynamic> json) {
    sId = json['id'];
    name = json['name'];
    category = json['category'];
  }

  Map<String, String?> toJson() {
    return <String, String?>{
      'id': sId,
      'name': name,
      'category': category,
    };
  }
}
