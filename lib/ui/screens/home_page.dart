import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:papua_tourism/bloc/auth_bloc/authentication_bloc.dart';
import 'package:papua_tourism/bloc/tourism_bloc/tourism_bloc.dart';
import 'package:papua_tourism/bloc/tourism_bloc/tourism_event.dart';
import 'package:papua_tourism/bloc/tourism_bloc/tourism_state.dart';
import 'package:papua_tourism/model/tourism_model.dart';
import 'package:papua_tourism/config/api.dart';
import 'package:papua_tourism/repository/tourism_repository.dart';
import 'package:papua_tourism/res/styling.dart';
import 'package:papua_tourism/ui/screens/add_tourism_screen.dart';
import 'package:papua_tourism/ui/screens/tourism_detail_screen.dart';
import 'package:papua_tourism/ui/widget/search_item.dart';
import 'package:papua_tourism/ui/widget/slider_item.dart';
import 'package:papua_tourism/ui/widget/tourism_item.dart';

class LandingHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TourismBloc(TourismRepositoryImpl()),
      child: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TourismBloc _tourismBloc;
  var searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tourismBloc = BlocProvider.of<TourismBloc>(context);
    _tourismBloc.add(FetchTourismEvent());
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0,
        backgroundColor: AppTheme.appBackgroundColor,
        title: _appBar(),
      ),
      body: _homeBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!

          navigateToFormDetailPage(context);
        },
        child: Icon(Icons.add_a_photo),
        backgroundColor: AppTheme.selectedTabBackgroundColor,
      ),
    );
  }

  Widget _appBar() {
    return SearchItem(
      controller: searchController,
      onClick: () {},
      readOnly: true,
    );
  }

  Widget _homeBody() {
    return BlocListener<TourismBloc, TourismState>(
      listener: (context, state) {
        if (state is TourismErrorState) {
          Scaffold.of(context).showSnackBar(SnackBar(content: Text(state.msg)));
        }
      },
      child: BlocBuilder<TourismBloc, TourismState>(
        builder: (context, state) {
          print("state $state");
          if (state is TourismInitialState) {
            return _buildLoading();
          } else if (state is TourismLoadingState) {
            return _buildLoading();
          } else if (state is TourismLoadedState) {
            return _buildTourism(state.tourisms);
          } else if (state is TourismErrorState) {
            return _buildErrorUi(state.msg);
          }
        },
      ),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildErrorUi(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  Widget _buildTourism(List<Tourism> tourisms) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _collectionTitle("Terbaru"),
            SizedBox(height: 10),
            _tourismNavbar(tourisms),
            SizedBox(height: 20),
            _collectionTitle("Rekomendasi Untuk Anda"),
            SizedBox(height: 10),
            _tourismItemList(tourisms),
          ],
        ),
      ),
    );
  }

  Widget _collectionTitle(title) {
    return Text(
      title,
      style: TextStyle(
          color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 18),
    );
  }

  Widget _tourismNavbar(List<Tourism> tourisms) {
    if (tourisms.length == 0) {
      return Center(
        child: Text("Tourism not found"),
      );
    }

    return Container(
      height: 150,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: tourisms.length,
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          var tourism = tourisms[index];
          return SliderItem(tourism);
        },
      ),
    );
  }

  Widget _tourismItemList(List<Tourism> tourisms) {
    if (tourisms.length == 0) {
      return Center(
        child: Text("Tourism not Found"),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: tourisms.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        var tourism = tourisms[index];
        return TourismItem(tourism);
      },
    );
  }

  void navigateToFormDetailPage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddTourismScreen(_tourismBloc);
    }));
  }
}
