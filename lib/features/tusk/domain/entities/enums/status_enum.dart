enum StatusEnum {
  uncompleted,
  completed,
  urgent,
}

extension ConvertEnumToString on StatusEnum {
  String get localizer {
    switch (this) {
      case StatusEnum.uncompleted:
        return 'uncompleted';
      case StatusEnum.completed:
        return 'completed';
      case StatusEnum.urgent:
        return 'urgent';
    }
  }
}
