class PhotoModel{
  int? total,totalHits;
  List<HitsModel>? hitsList = [];

  PhotoModel({this.total, this.totalHits, this.hitsList});

  factory PhotoModel.mapToModel(Map m1){
    List l1 = m1['hits'];
    return PhotoModel(
      total: m1['total'],
      totalHits: m1['totalHits'],
      hitsList: l1.map((e)=>HitsModel.mapToModel(e)).toList(),
    );
  }
}

class HitsModel{
  int? id,previewWidth,previewHeight,webformatWidth,webformatHeight,imageWidth,imageHeight,imageSize,views,downloads,collections,likes,comments,user_id;
  String? pageURL,type,tags,previewURL,webformatURL,largeImageURL,user,userImageURL;

  HitsModel(
      {this.id,
        this.previewWidth,
        this.previewHeight,
        this.webformatWidth,
        this.webformatHeight,
        this.imageWidth,
        this.imageHeight,
        this.imageSize,
        this.views,
        this.downloads,
        this.collections,
        this.likes,
        this.comments,
        this.user_id,
        this.pageURL,
        this.type,
        this.tags,
        this.previewURL,
        this.webformatURL,
        this.largeImageURL,
        this.user,
        this.userImageURL});

  factory HitsModel.mapToModel(Map m1){
    return HitsModel(
      collections: m1['collections'],
      comments: m1['comments'],
      downloads: m1['downloads'],
      id: m1['id'],
      imageHeight: m1['imageHeight'],
      imageSize: m1['imageSize'],
      imageWidth: m1['imageWidth'],
      largeImageURL: m1['largeImageURL'],
      likes: m1['likes'],
      pageURL: m1['pageURL'],
      previewHeight: m1['previewHeight'],
      previewURL: m1['previewURL'],
      previewWidth: m1['previewWidth'],
      tags: m1['tags'],
      type: m1['type'],
      user: m1['user'],
      user_id: m1['user_id'],
      userImageURL: m1['userImageURL'],
      views: m1['views'],
      webformatHeight: m1['webformatHeight'],
      webformatURL: m1['webformatURL'],
      webformatWidth: m1['webformatWidth'],
    );
  }
}