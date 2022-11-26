class Product {
    Product({
        this.name,
        this.cost,
        this.group,
        this.CementType,
        this.company,
        this.quantity,
        this.image,
        this.description,
    });

    String? name;
    double? cost;
    String? group;
    String? CementType;
    String? company;
    int? quantity;
    String? image;
    String? description;

    factory Product.fromMap(Map<String, dynamic> json) => Product(
        name: json["name"] as String?,
        cost: json["cost"] as double?,
        group: json["group"] as String?,
        CementType: json["CementType"] as String?,
        company: json["company"] as String?,
        quantity: json["quantity"] as int?,

       // image: json["image"] as String?,
        description: json["description"] as String?,
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "cost": cost,
        "group": group,
        "CementType": CementType,
        // "company": company,
        "quantity": quantity,
       // "image": image,
        "description": description,
    };
}
