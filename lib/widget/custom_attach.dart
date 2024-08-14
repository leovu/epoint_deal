// part of widget;

// class CustomAttach extends StatelessWidget {
//   final String? path;

//   CustomAttach({this.path});

//   @override
//   Widget build(BuildContext context) {
//     String name = "";
//     if(path!.contains("/")){
//       name = path!.split("/").last;
//     }
//     return InkWell(
//       child: Text(
//         name,
//         style: AppTextStyles.style14BlueNormal,
//       ),
//       onTap: () => openFile(context, name, path),
//     );
//   }
// }
