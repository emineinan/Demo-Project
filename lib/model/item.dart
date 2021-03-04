class Item {
  int id;
  String todo;

  Item(this.todo);
  Item.withId(this.id, this.todo);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["id"] = id;
    map["todo"] = todo;
    return map;
  }

  Item.fromMap(Map<String, dynamic> map) {
    this.id = map["id"];
    this.todo = map["todo"];
  }
}
