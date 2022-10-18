class Salesproduct{
  Salesproduct({
    this.name,
    this.cost,
    this.group,
    this.CementType,
    this.company,
    this.quantity,
    this.image,
    this.description,
    this.finalprice,
    this.salesprice,
});
  String? name;
  double? cost;
  double? finalprice;
  String? group;
  String? CementType;
  String? company;
  int? quantity;
  String? image;
  String? description;
  int? salesprice;
  factory Salesproduct.fromMap(Map<String, dynamic> json) => Salesproduct(
    name: json["name"] as String?,
    cost: json["cost"] as double?,
    group: json["group"] as String?,
    CementType: json["CementType"] as String?,
    company: json["company"] as String?,
    quantity: json["quantity"] as int?,
    salesprice: json['SalesPrice'] as int?,
    finalprice: json['finalprice'] as double?,

    // image: json["image"] as String?,
    description: json["description"] as String?,
  );

  Map<String, dynamic> toMap() => {
    "name": name,
    "cost": cost,
    "group": group,
    "CementType": CementType,
    "company": company,
    "quantity": quantity,
    "SalesPrice":salesprice,
    "finalprice":finalprice,
    // "image": image,
    "description": description,
  };
}