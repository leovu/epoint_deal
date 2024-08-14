part of widget;

class CustomApproveAvatar extends StatelessWidget {

  final int? isApproved;
  final String? url;
  final String? name;
  final double? size;

  const CustomApproveAvatar({
    Key? key,
    this.isApproved,
    this.url,
    this.name,
    this.size
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double _avatarSize = size ?? 40.0;
    double _approveSize = _avatarSize / 2;

    bool? _isApproved = isApproved == null? null: isApproved == 1;

    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Padding(
          padding: EdgeInsets.only(right: _isApproved == null
              ? 0.0
              : _approveSize / 2),
          child: CustomAvatar(
            url: url,
            size: _avatarSize,
            name: name,
            borderColor: _isApproved == null
                ? null
                : _isApproved
                ? AppColors.green300
                : AppColors.red500,
          ),
        ),
        if(_isApproved != null)
          Icon(
            _isApproved ? Icons.check_circle: Icons.remove_circle,
            size: _approveSize,
            color: _isApproved ? AppColors.green300 : AppColors.red500,
          )
      ],
    );
  }
}
