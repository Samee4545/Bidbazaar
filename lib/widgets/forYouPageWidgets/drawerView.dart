import 'package:flutter/material.dart';

Widget drawerView(context, drawerList) {
  return Drawer(
    backgroundColor: Colors.white,
    child: Column(
      children: [
        Stack(children: [
          ClipPath(
            clipper: BlackClipper(),
            child: Container(
              height: 160,
              color: Colors.black,
            ),
          ),
          ClipPath(
            clipper: RedClipper(),
            child: Container(
              height: 160,
              color: Colors.red,
            ),
          ),
          ClipPath(
            clipper: OrangeClipper(),
            child: Container(
              height: 160,
              color: Colors.orange,
            ),
          )
        ]),
        const SizedBox(
          height: 20,
        ),
        ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 0),
          shrinkWrap: true,
          itemCount: drawerList.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: drawerList[index].icon,
              iconColor: Colors.grey.shade700,
              title: Text(
                drawerList[index].title!,
                style: const TextStyle(color: Colors.black),
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Divider(
            color: Colors.black.withOpacity(.9),
          ),
        ),
        const ListTile(
          leading: Icon(
            Icons.logout_rounded,
            color: Colors.orange,
          ),
          title: Text(
            "Log Out",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.orange),
          ),
        )
      ],
    ),
  );
}

class RedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.0020000);
    path_0.lineTo(0, size.height);
    path_0.quadraticBezierTo(size.width * 0.1000125, size.height * 0.9313800,
        size.width * 0.2426625, size.height * 0.9082600);
    path_0.cubicTo(
        size.width * 0.4019125,
        size.height * 0.8988000,
        size.width * 0.5479250,
        size.height * 0.9795600,
        size.width * 0.7487500,
        size.height * 1.0006600);
    path_0.quadraticBezierTo(size.width * 0.9376250, size.height * 0.9861000,
        size.width * 0.9987500, size.height * 0.9015200);
    path_0.lineTo(size.width, size.height * 0.6980000);
    path_0.lineTo(size.width, 0);
    path_0.lineTo(0, size.height * 0.0020000);
    path_0.close();
    return path_0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}

class OrangeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.0020000);
    path_0.lineTo(0, size.height);
    path_0.quadraticBezierTo(size.width * 0.1037625, size.height * 0.9093800,
        size.width * 0.2464125, size.height * 0.8862600);
    path_0.cubicTo(
        size.width * 0.4056625,
        size.height * 0.8668000,
        size.width * 0.5479250,
        size.height * 0.9795600,
        size.width * 0.7487500,
        size.height * 1.0006600);
    path_0.quadraticBezierTo(size.width * 0.9376250, size.height * 0.9861000,
        size.width * 0.9987500, size.height * 0.9015200);
    path_0.lineTo(size.width, size.height * 0.6980000);
    path_0.lineTo(size.width, 0);
    path_0.lineTo(0, size.height * 0.0020000);
    path_0.close();
    return path_0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}

class BlackClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.0020000);
    path_0.lineTo(0, size.height);
    path_0.quadraticBezierTo(size.width * 0.1232875, size.height * 0.9500800,
        size.width * 0.2638625, size.height * 0.9343000);
    path_0.cubicTo(
        size.width * 0.4231125,
        size.height * 0.9248400,
        size.width * 0.6150375,
        size.height * 0.9975400,
        size.width * 0.7387500,
        size.height * 0.9946800);
    path_0.quadraticBezierTo(size.width * 0.8636000, size.height * 1.0076600,
        size.width * 0.9987500, size.height * 0.9375200);
    path_0.lineTo(size.width, size.height * 0.6980000);
    path_0.lineTo(size.width, 0);
    path_0.lineTo(0, size.height * 0.0020000);
    path_0.close();
    return path_0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}
