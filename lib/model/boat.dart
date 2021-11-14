class Boat {
  /*final String imagePath;*/
  final int id;
  final String name;
  final int? size;

  Boat(
      /*this.imagePath,*/
      this.id,
      this.name,
      this.size,
      );

/*  factory Boat.fromJson(Map<String, dynamic> json){
   return Boat(
     id: json['IDBarco'],
     name: json['nome'],
     size: json['tamanho'],
   );
  }*/

  @override
  String toString() {
    return 'Boat{id: $id, name: $name, size: $size}';
  }
}