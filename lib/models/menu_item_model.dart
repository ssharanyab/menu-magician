class MenuItem {
  final int? id;
  final String meal;
  final String itemName;
  final String itemDescription;

  const MenuItem({
    this.id,
    required this.meal,
    required this.itemName,
    required this.itemDescription,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) => MenuItem(
        id: json['id'],
        meal: json['meal'],
        itemName: json['itemName'],
        itemDescription: json['itemDescription'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'meal': meal,
        'itemName': itemName,
        'itemDescription': itemDescription,
      };
}
