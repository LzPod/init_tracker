class Character {
  final String name;
  final int initiative;
  final int? armorClass;
  final int? hitPoints;
  final bool isMonster;

  Character({
    required this.name,
    required this.initiative,
    this.armorClass,
    this.hitPoints,
    required this.isMonster,
  });
}
