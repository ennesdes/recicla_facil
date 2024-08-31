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

  int get number {
    switch (this) {
      case TrashTypeEnum.recyclable:
        return 1;
      case TrashTypeEnum.organic:
        return 2;
      case TrashTypeEnum.electronic:
        return 3;
      case TrashTypeEnum.chemical:
        return 4;
      case TrashTypeEnum.construction:
        return 5;
      case TrashTypeEnum.hospital:
        return 6;
      default:
        return 0; // Caso não seja encontrado, retorna 0 ou outro valor padrão.
    }
  }
}
