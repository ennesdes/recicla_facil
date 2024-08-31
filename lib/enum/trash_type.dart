enum TrashTypeEnum {
  recyclable,
  organic,
  electronic,
  chemical,
  construction,
  hospital,
}

extension TrashTypeEnumExtension on TrashTypeEnum {
  String get description {
    switch (this) {
      case TrashTypeEnum.recyclable:
        return 'Reciclável';
      case TrashTypeEnum.organic:
        return 'Orgânico';
      case TrashTypeEnum.electronic:
        return 'Eletrônico';
      case TrashTypeEnum.chemical:
        return 'Químico';
      case TrashTypeEnum.construction:
        return 'Construção';
      case TrashTypeEnum.hospital:
        return 'Hospitalar';
      default:
        return '';
    }
  }
}
