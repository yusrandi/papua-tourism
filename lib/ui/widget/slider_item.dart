import 'package:flutter/material.dart';
import 'package:papua_tourism/config/api.dart';
import 'package:papua_tourism/model/tourism_model.dart';
import 'package:papua_tourism/ui/screens/tourism_detail_screen.dart';

class SliderItem extends StatelessWidget {
  Tourism tourism;
  SliderItem(this.tourism);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [_imageCover(), _gradientBlack(), _titleCount()],
    );
  }

  Widget _imageCover() {
    return Container(
      width: 120,
      height: 150,
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          image: DecorationImage(
              image: NetworkImage("${Api.instance.imageUrl}/${tourism.images}"),
              fit: BoxFit.cover)),
    );
  }

  Widget _gradientBlack() {
    return Container(
      width: 120,
      height: 150,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black87.withOpacity(0.8)])),
    );
  }

  Widget _titleCount() {
    return Container(
      width: 120,
      height: 150,
      child: Material(
        type: MaterialType.transparency,
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(5),
          child: Padding(
            padding: const EdgeInsets.all(7),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  tourism.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  tourism.open,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void navigateToArticleDetailPage(BuildContext context, Tourism tourism) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return TourismDetailScreen(tourism);
    }));
  }
}
