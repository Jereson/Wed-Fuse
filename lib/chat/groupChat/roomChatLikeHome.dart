
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'gridViewForCountry.dart';
import 'listViewContry.dart';


class RoomChatLikeHome extends StatefulWidget {
   const RoomChatLikeHome({Key? key, required this.country,required this.state}) : super(key: key);
 final String country;
 final String state;

  @override
  State<RoomChatLikeHome> createState() => _RoomChatLikeHomeState();
}

class _RoomChatLikeHomeState extends State<RoomChatLikeHome> {
  bool isGrid = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 182, 183, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 182, 183, 1),
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                isGrid=!isGrid;
                setState(() {

                });
              },
              icon: Icon(
                isGrid? Icons.grid_view_rounded:Icons.list_rounded,
                size: 35,
                color: Colors.black,
              )),

        ],
        leading:             InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(Icons.cancel,color: Colors.black,size: 30,),
        ),
          centerTitle: true,
        title: Text(
          "${widget.country} / ${widget.state}",
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
      body: isGrid? GridViewCountries(widget: widget):
      ListViewCountry(widget: widget),
    );
  }
}


