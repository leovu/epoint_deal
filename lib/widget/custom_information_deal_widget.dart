part of widget;

class CustomInformationDealWidget extends StatelessWidget {
  const CustomInformationDealWidget({super.key, this.name, this.type});
  final String? name;
  final String? type;

  @override
  Widget build(BuildContext context) {
    print(name);
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: AppSizes.minPadding!, vertical: AppSizes.minPadding!/2),
      decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(6.0)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomAvatarDetail(
            color: Color(0xFFEEB132),
            name: name ?? "",
            padding: 4.0,
            textSize: 12,
          ),
          SizedBox(width: 4.0,),
          Expanded(
            child: Text(
              name ?? "",
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: AppColors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold),
              // maxLines: 1,
            ),
          ),
          Text(
            type ?? "",
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.end,
            style: TextStyle(
                color: AppColors.white,
                fontSize: 14.0,
                fontWeight: FontWeight.w500),
            // maxLines: 1,
          )
        ],
      ),
    );
  }
}