class Category {
  static const String sportsId = 'sports';
  static const String moviesId = 'movies';
  static const String musicId = 'music';
  String id ;
  late String title ;
  late String image ;

  Category({required this.id, required this.title , required this.image});

  Category.fromId(this.id){
    if(id == sportsId){
      title = 'Sports';
      image = 'assets/images/sports.png';
    } else if(id == moviesId){
      title = 'Movies';
      image = 'assets/images/movies.png';
    }else if(id == musicId){
      title = 'Music';
      image = 'assets/images/music.png';
    }
  }

  static List<Category> getCategory(){
    return [
      Category.fromId(sportsId),
      Category.fromId(musicId),
      Category.fromId(moviesId),
    ];
  }
}