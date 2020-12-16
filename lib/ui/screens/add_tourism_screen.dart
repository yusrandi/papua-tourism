import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:papua_tourism/bloc/tourism_bloc/tourism_bloc.dart';
import 'package:papua_tourism/bloc/tourism_bloc/tourism_event.dart';
import 'package:papua_tourism/bloc/tourism_bloc/tourism_state.dart';
import 'package:papua_tourism/model/tourism_model.dart';
import 'package:papua_tourism/repository/tourism_repository.dart';
import 'package:papua_tourism/ui/constant/constant.dart';

class AddTourismScreen extends StatefulWidget {
  TourismBloc _tourismBloc;
  AddTourismScreen(this._tourismBloc);

  @override
  _AddTourismScreenState createState() => _AddTourismScreenState();
}

class _AddTourismScreenState extends State<AddTourismScreen> {
  final _tourismName = new TextEditingController();
  final _tourismAdress = new TextEditingController();
  final _tourismPrice = new TextEditingController();
  final _tourismOpen = new TextEditingController();
  final _tourismRating = new TextEditingController();
  final _tourismDetail = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Tourism")),
      body: _body(),
    );
  }

  Widget _body() {
    return Container(
      width: deviceWith(context),
      padding: const EdgeInsets.all(10),
      child: Stack(
        children: [_bodyFormInput(), _blocBody()],
      ),
    );
  }

  Widget _blocBody() {
    return BlocListener<TourismBloc, TourismState>(
      listener: (context, state) {
        if (state is TourismErrorState) {
          Scaffold.of(context).showSnackBar(SnackBar(content: Text(state.msg)));
        }
      },
      child: BlocBuilder<TourismBloc, TourismState>(
        builder: (context, state) {
          if (state is TourismInitialState) {
            return _buildLoading();
          } else if (state is TourismLoadingState) {
            return _buildLoading();
          } else if (state is TourismSuccessState) {
            return _buildErrorUi(state.msg);
          } else if (state is TourismErrorState) {
            return _buildErrorUi(state.msg);
          }
        },
      ),
    );
  }

  Widget _bodyFormInput() {
    return Container(
      width: deviceWith(context),
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _title("Add a new Tourism"),
            SizedBox(height: 16),
            _formName("Tourism Name", "Input Tourism Name", _tourismName),
            SizedBox(height: 10),
            _formName("Tourism Adress", "Input Tourism Adress", _tourismAdress),
            SizedBox(height: 10),
            _formName("Tourism Price", "Rp. 000.0000.000", _tourismPrice),
            SizedBox(height: 10),
            _formName("Tourism Open", "07:00 AM - 05:00 PM", _tourismOpen),
            SizedBox(height: 10),
            _formName("Tourism Rating", "1-5", _tourismRating),
            SizedBox(height: 10),
            _formName(
                "Tourism Detail", "Tourism Detail Information", _tourismDetail),
            SizedBox(height: 20),
            _formButtonSubmit()
          ],
        ),
      ),
    );
  }

  Widget _title(title) {
    return Text(
      title,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16),
    );
  }

  Widget _formName(labelText, hintText, controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
  }

  Widget _formButtonSubmit() {
    return Container(
      width: deviceWith(context),
      height: 60,
      child: OutlinedButton(
        onPressed: () {
          print("Name ${_tourismName.text}, Adress ${_tourismAdress.text}");
          var tourism = Tourism(
              id: 0,
              images: "",
              name: _tourismName.text,
              adress: _tourismAdress.text,
              price: _tourismPrice.text,
              open: _tourismOpen.text,
              rating: _tourismRating.text,
              detail: _tourismDetail.text,
              createdAt: "",
              updatedAt: "");
          widget._tourismBloc.add(CreateTourismEvent(tourism));
        },
        child: Text(
          "Submit",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16),
        ),
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
}
