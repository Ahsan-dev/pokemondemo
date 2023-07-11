class Pokemon{
  final String name;
  final String id;
  final Weight weight;
  final Height height;
  final String classification;
  final String image;

  Pokemon({
    required this.name,
    required this.id,
    required this.weight,
    required this.height,
    required this.classification,
    required this.image,
  });
}

class Weight{
  final String minimum;
  final String maximum;

  Weight({
    required this.minimum,
    required this.maximum
  });
}

class Height{
  final String minimum;
  final String maximum;

  Height({
    required this.minimum,
    required this.maximum
  });
}