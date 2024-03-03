class planteCarePlantsAddModel
{
  String ? name;
  int ? id;
  String ? image;
  int ? fertilizeIn;
  int ? irrigationIn;
  String ? dateTime;
  String ? lastWateredDate;
  String ? idForTasks;


  planteCarePlantsAddModel({
    this.name
    ,this.id
    ,this.image
    ,this.fertilizeIn
    ,this.irrigationIn
    ,this.dateTime
    ,this.lastWateredDate
    ,this.idForTasks

  });

  planteCarePlantsAddModel.fromJson(Map<String,dynamic>json)
  {
    name=json['name'];
    id=json['id'];
    image=json['image'];
    fertilizeIn=json['fertilizeIn'];
    irrigationIn=json['irrigationIn'];
    dateTime=json['dateTime'];
    lastWateredDate=json['createdAt'];
    idForTasks=json['idForTasks'];

  }

  Map<String,dynamic> toMap()
  {
    return{
      'name':name,
      'id':id,
      'image':image,
      'fertilizeIn':fertilizeIn,
      'irrigationIn':irrigationIn,
      'dateTime':dateTime,
      'createdAt':lastWateredDate,
      'idForTasks':idForTasks,
    };
  }
}