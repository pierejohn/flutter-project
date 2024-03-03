class planteCarePlantsModel
{
  String ? name;
  int ? id;
  String ? image;
  int ? fertilizeIn;
  int ? irrigationIn;


  planteCarePlantsModel({
    this.name
    ,this.id
    ,this.image
    ,this.fertilizeIn
    ,this.irrigationIn

  });

  planteCarePlantsModel.fromJson(Map<String,dynamic>json)
  {
    name=json['name'];
    id=json['id'];
    image=json['image'];
    fertilizeIn=json['fertilizeIn'];
    irrigationIn=json['irrigationIn'];

  }

  Map<String,dynamic> toMap()
  {
    return{
      'name':name,
      'id':id,
      'image':image,
      'fertilizeIn':fertilizeIn,
      'irrigationIn':irrigationIn,
    };
  }
}