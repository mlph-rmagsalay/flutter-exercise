class Equipment {
  String code;
  String description;
  String specs;
  String imageUrl;
  bool isAssigned;
  String assignedTo;

  Equipment({
    this.code = '',
    this.description = '',
    this.specs = '',
    this.imageUrl = '',
    this.isAssigned = false,
    this.assignedTo = '',
  });
}
