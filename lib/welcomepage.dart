import 'package:flutter/material.dart';
import 'package:pixel_adventure/pixel_adventure_page.dart';

class welcomepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // image: Image.asset('images/bakugo.png'),
        title: Text('Chào Mừng'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Cảm ơn vì đã sử dụng sản phẩm của mình!',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              Image.asset(
                'images/me.png',
                height: 200, // Đặt chiều cao của ảnh tùy ý
                width: 200, // Đặt chiều rộng của ảnh tùy ý
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PixelAdventurePage()),
                  );
                },
                child: Text('Chơi Ngay'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
