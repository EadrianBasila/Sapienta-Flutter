class AlarmInfo {
  int id;
  String title;
  DateTime alarmDateTime;
  String planTitle;
  String planCost;
  bool isPending;
  int gradientColorIndex;

  AlarmInfo(
      {this.id,
      this.title,
      this.alarmDateTime,
      this.planTitle,
      this.planCost,
      this.isPending,
      this.gradientColorIndex});

  factory AlarmInfo.fromMap(Map<String, dynamic> json) => AlarmInfo(
        id: json["id"],
        title: json["title"],
        alarmDateTime: DateTime.parse(json["alarmDateTime"]),
        planTitle: json["planTitle"],
        planCost: json["planCost"],
        isPending: json["isPending"],
        gradientColorIndex: json["gradientColorIndex"],
      );
  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "alarmDateTime": alarmDateTime.toIso8601String(),
        "planTitle": planTitle,
        "planCost": planCost,
        "isPending": isPending,
        "gradientColorIndex": gradientColorIndex,
      };
}
