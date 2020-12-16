import 'package:flutter/material.dart';
import 'package:papua_tourism/config/api.dart';
import 'package:papua_tourism/model/tourism_model.dart';
import 'package:papua_tourism/ui/constant/constant.dart';
import 'package:papua_tourism/ui/screens/tourism_detail_screen.dart';

import 'custom_rating.dart';

class TourismItem extends StatefulWidget {
  Tourism tourism;
  TourismItem(this.tourism);

  @override
  _TourismItemState createState() => _TourismItemState();
}

class _TourismItemState extends State<TourismItem> {
  bool isLongPress = false;
  double marginVertical = 10;
  double marginHorizontal = 0;

  void onClick() {
    navigateToArticleDetailPage(context, widget.tourism);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(),
      width: deviceWith(context),
      margin: EdgeInsets.symmetric(
          vertical: marginVertical, horizontal: marginHorizontal),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 4),
                blurRadius: 9,
                spreadRadius: 1,
                color: Colors.black12.withOpacity(0.1))
          ]),
      child: GestureDetector(
        onTap: () {
          navigateToArticleDetailPage(context, widget.tourism);
        },
        onLongPress: () {},
        onLongPressEnd: (val) {},
        child: Column(
          children: [
            _imageCover(),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _title(),
                  SizedBox(height: 5),
                  CustomRating(
                    rating: double.parse(widget.tourism.rating),
                    review: 100,
                  ),
                  SizedBox(height: 5),
                  _cuisines(),
                  SizedBox(height: 5),
                  _price()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _imageCover() {
    return Container(
      height: 180,
      decoration: BoxDecoration(
          color: Colors.grey,
          image: DecorationImage(
              image: NetworkImage(
                  "${Api.instance.imageUrl}/${widget.tourism.images}"),
              fit: BoxFit.cover),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8))),
    );
  }

  Widget _title() {
    return Text(
      widget.tourism.name,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16),
    );
  }

  Widget _cuisines() {
    return Text(
      widget.tourism.adress,
      style: TextStyle(color: Colors.black45, fontSize: 12),
    );
  }

  Widget _price() {
    return Text(
      widget.tourism.price,
      style: TextStyle(
          color: Colors.green, fontSize: 14, fontWeight: FontWeight.bold),
    );
  }

  void navigateToArticleDetailPage(BuildContext context, Tourism tourism) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return TourismDetailScreen(tourism);
    }));
  }
}
