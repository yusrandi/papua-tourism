import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:papua_tourism/config/api.dart';
import 'package:papua_tourism/model/tourism_model.dart';
import 'package:papua_tourism/ui/widget/custom_rating.dart';

class TourismDetailScreen extends StatelessWidget {
  Tourism tourism;
  TourismDetailScreen(this.tourism);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TourismDetailBody(
        tourism,
      ),
    );
  }
}

class TourismDetailBody extends StatefulWidget {
  Tourism tourism;
  TourismDetailBody(this.tourism);

  @override
  _TourismDetailBodyState createState() => _TourismDetailBodyState();
}

class _TourismDetailBodyState extends State<TourismDetailBody> {
  Color iconBackColor = Colors.white;
  Color textColor = Colors.white;
  Color backgroundColor = Colors.transparent;

  ScrollController scrollController;
  _scrollListener() {
    if (scrollController.offset >= 100) {
      setState(() {
        iconBackColor = Colors.black87;
        textColor = Colors.black87;
        backgroundColor = Colors.white;
      });
    } else {
      setState(() {
        iconBackColor = Colors.white;
        textColor = Colors.white;
        backgroundColor = Colors.transparent;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    scrollController = new ScrollController();
    scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            controller: scrollController,
            child: _content()),
        _appBar(),
      ],
    );
  }

  Widget _appBar() {
    return Builder(
      builder: (context) {
        return Column(
          children: <Widget>[
            Container(
              height: 24,
              color: backgroundColor,
            ),
            Container(
              height: 50,
              color: backgroundColor,
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: iconBackColor),
                    onPressed: () => Navigator.pop(context),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      widget.tourism.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _content() {
    return Container(
      child: Column(
        children: <Widget>[
          _imageCover(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 5),
                CustomRating(
                  rating: double.parse(widget.tourism.rating),
                  review: 190,
                ),
                SizedBox(height: 15),
                _title(),
                SizedBox(height: 5),
                _cuisines(),
                SizedBox(height: 5),
                _address(),
                SizedBox(height: 5),
                _price(),
                Divider(color: Colors.black12),
                SizedBox(height: 10),
                _openTime(),
                SizedBox(height: 10),
                _addressFull(),
                SizedBox(height: 10),
                Divider(color: Colors.black12),
                SizedBox(height: 15),
                _reviews(),
                SizedBox(height: 20),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _imageCover() {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        color: Colors.grey,
        image: DecorationImage(
            image: NetworkImage(
                "${Api.instance.imageUrl}/${widget.tourism.images}"),
            fit: BoxFit.cover),
      ),
    );
  }

  Widget _title() {
    return Text(
      widget.tourism.name,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 18),
    );
  }

  Widget _cuisines() {
    return Text(
      "widget.Tourism.cuisines",
      style: TextStyle(color: Colors.black87, fontSize: 12),
    );
  }

  Widget _address() {
    return Text(
      widget.tourism.adress,
      style: TextStyle(color: Colors.black87, fontSize: 12),
    );
  }

  Widget _price() {
    return Text(
      widget.tourism.price,
      style: TextStyle(
          color: Colors.green, fontSize: 14, fontWeight: FontWeight.bold),
    );
  }

  Widget _addressFull() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Detail Pariwisata",
          style: TextStyle(
              color: Colors.black87, fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5),
        Html(
          data: widget.tourism.detail,
        ),
      ],
    );
  }

  Widget _openTime() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Jam Buka",
          style: TextStyle(
              color: Colors.black87, fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5),
        Text(
          widget.tourism.open,
          style: TextStyle(color: Colors.black87, fontSize: 12),
        ),
      ],
    );
  }

  Widget _reviews() {
    return Builder(
      builder: (context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Review Terbaru",
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            // _reviewList()
          ],
        );
      },
    );
  }
}
