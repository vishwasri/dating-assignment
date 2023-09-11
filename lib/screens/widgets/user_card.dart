import 'package:dating/models/User.dart';
import 'package:dating/utils/colors.dart';
import 'package:flutter/material.dart';

import '../../utils/text_styles.dart';

class UserCard extends StatefulWidget {
  final User user;
  const UserCard(this.user,{super.key});

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  int _selectedImage = 0;

  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(children: [
          _buildImageView(),
          _buildImageIndicators(),
          _buildImageNavigators(),
          _buildGradientMask(),
          _buildUserDetails(),
        ],),
      ),
    );
  }

  void _nextImage(){
    setState(() {
      if(_selectedImage < widget.user.images.length-1) {
        _selectedImage++;
      }
    });
  }

  void _previousImage(){
    setState(() {
      if(_selectedImage > 0) {
        _selectedImage--;
      }
    });
  }

  _buildImageView() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(
        widget.user.images[_selectedImage],
        height: double.infinity,
        width: double.infinity,
        fit: BoxFit.cover,
        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress){
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null ?
              loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.white,
            alignment: Alignment.center,
            child: const Text(
              'oops!',
              style: TextStyle(fontSize: 30),
            ),
          );
        },
      ),
    );
  }

  _buildImageIndicators() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
      child: Row(children: widget.user.images.map((e) => Expanded(
        child: Container(
          height: 5,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
              color: widget.user.images[_selectedImage] ==  e ? colorPink : Colors.black,
              borderRadius: BorderRadius.circular(4)
          ),
        ),
      )).toList(),),
    );
  }

  _buildImageNavigators() {
    return SizedBox(
      height: MediaQuery.of(context).size.height/3,
      child: Row(children: [
        Expanded(
          child: GestureDetector(
            onTap: _previousImage,
            child: Container(
              height: double.infinity,
              color: Colors.transparent,
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: _nextImage,
            child: Container(
              height: double.infinity,
              color: Colors.transparent,
            ),
          ),
        )
      ],),
    );
  }

  _buildGradientMask() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        height: MediaQuery.of(context).size.height/2,
        decoration:  BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [Colors.transparent, Colors.black54],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
    );
  }

  _buildUserDetails() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 85,
                    padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.star,color: Colors.white54,),
                        const SizedBox(width: 10,),
                        Text(widget.user.likeCount.toString(),style: txtParagraph,),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Text(widget.user.name,style: txtHeader,),
                  const SizedBox(height: 10,),
                  _buildThirdRowData(_selectedImage),
                ],
              ),
            ),
            SizedBox(
              width: 100,
              height: 100,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.blue,width: 2)
                  ),
                  child: const Icon(Icons.favorite,color: Colors.blue,),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildThirdRowData(int index){
    switch(index){
      case 0: {
        return Text(widget.user.location,style: txtSubHeader,);
      }
      case 1: {
        return Text(widget.user.description,style: txtSubHeader,);
      }
      case 2: {
        return Wrap(
          spacing:5.0,
          runSpacing: 5.0,
          children: widget.user.tags.map((e) =>
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Text(e,style: txtParagraph,),
              )
          ).toList(),
        );
      }
      default: {
        return Text(widget.user.location,style: txtSubHeader,);
      }
    }
  }
}
