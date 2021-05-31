import 'package:flutter/material.dart';

class AvatarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Avatar Page"),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10.0),
            child: CircleAvatar(
              child: Text("NX"),
              backgroundColor: Colors.black,
            ),
          ),
          Container(
            padding: EdgeInsets.all(5.0),
            child: CircleAvatar(
              radius: 20.0,
              backgroundImage: NetworkImage('https://images.pexels.com/photos/672636/pexels-photo-672636.jpeg?cs=srgb&dl=blaze-bonfire-burn-672636.jpg&fm=jpg'),
              backgroundColor: Colors.black,
            ),
          )
        ],        
      ),
      body: Center(
          child: FadeInImage(
             image:  NetworkImage('https://o.aolcdn.com/images/dims?quality=85&image_uri=https%3A%2F%2Fo.aolcdn.com%2Fimages%2Fdims%3Fcrop%3D4488%252C2525%252C0%252C0%26quality%3D85%26format%3Djpg%26resize%3D1600%252C900%26image_uri%3Dhttps%253A%252F%252Fs.yimg.com%252Fos%252Fcreatr-images%252F2019-06%252Fad5ed8b0-996d-11e9-8beb-2ee08ac7ac1d%26client%3Da1acac3e1b3290917d92%26signature%3Df245a7606c708ab449b9700a0fd9fb9f28723ffe&client=amp-blogside-v2&signature=ee28d12b44fdd9ffb859951f35063da83dcf7bea'),
             placeholder: AssetImage('assets/jar_loading.gif'),
             fadeInDuration: Duration(milliseconds: 100),
          ) 

      ), 
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.remove_circle_outline),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
