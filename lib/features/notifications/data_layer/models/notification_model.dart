class NotificationModel {
  final String title;
  final String body;

  NotificationModel({required this.title, required this.body});

  factory NotificationModel.toJson() {
    return NotificationModel(title: "title", body: "body");
  }
  factory NotificationModel.fromInput(){
    return NotificationModel(title: "", body: "");
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(title: json['title'], body: json['body']);
  }
}
