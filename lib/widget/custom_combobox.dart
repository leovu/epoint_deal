part of widget;

class ContainerComboBox extends StatelessWidget {

  final String? title;
  final Widget? child;
  final bool? expand;
  final Function(bool)? onChanged;

  ContainerComboBox({this.title, this.expand, this.child, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return CustomComboBox(
      title: title,
      onChanged: onChanged,
      titleSize: AppTextSizes.size11,
      expand: expand ?? true,
      backgroundColor: AppColors.whiteColor,
      child: Column(
        children: [
          CustomLine(),
          child!
        ],
      ),
    );
  }
}

class CustomComboBox extends StatefulWidget {
  final String? title;
  final Widget? titleWidget;
  final Widget? suffixTitle;
  final EdgeInsetsGeometry? titlePadding;
  final Widget? child;
  final Widget? header;
  final bool? expand;
  final Color? borderColor;
  final List<BoxShadow>? boxShadow;
  final String? icon;
  final double? titleSize;
  final Color? backgroundColor;
  final Function(bool)? onChanged;
  final GestureTapCallback? onTitleTap;
  final TextStyle? titleStyle;
  final BorderRadiusGeometry? borderRadius;

  CustomComboBox({
    Key? key,
    this.title,
    this.titleWidget,
    this.suffixTitle,
    this.titlePadding,
    this.child,
    this.header,
    this.expand = false,
    this.borderColor,
    this.boxShadow,
    this.icon,
    this.titleSize,
    this.backgroundColor,
    this.onChanged,
    this.onTitleTap,
    this.titleStyle,
    this.borderRadius
  }):super(key: key);

  @override
  CustomComboBoxState createState() => CustomComboBoxState();
}

class CustomComboBoxState extends State<CustomComboBox> {
  bool? _expand;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _expand = widget.expand;
  }

  @override
  void didUpdateWidget(covariant CustomComboBox oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

    if (_expand != widget.expand) {
      setState(() {
        _expand = widget.expand;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Widget _buildHeader() {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
            border: widget.borderColor == null?null:Border.all(color: widget.borderColor!),
            color: AppColors.whiteColor,
            borderRadius: widget.borderRadius,
            boxShadow: widget.boxShadow),
        padding: widget.titlePadding ?? EdgeInsets.symmetric(
            vertical: AppSizes.minPadding, horizontal: AppSizes.maxPadding),
        child: (widget.titleWidget == null && widget.title == null)
            ? CustomShimmer(
                child: Row(children: [
                CustomSkeleton(
                  width: AppSizes.sizeOnTap,
                  height: AppSizes.sizeOnTap,
                ),
                Container(width: AppSizes.minPadding,),
                Expanded(child: CustomSkeleton()),
              ]))
            : Column(
          children: [
            Row(
              children: [
                widget.icon == null?Container():Container(
                  width: AppSizes.sizeOnTap,
                  height: AppSizes.sizeOnTap,
                  margin: EdgeInsets.only(right: AppSizes.minPadding),
                  decoration: BoxDecoration(
                      color: AppColors.darkGreenColor,
                      shape: BoxShape.circle),
                  alignment: Alignment.center,
                  child: CustomImageIcon(
                    icon: widget.icon,
                    size: AppSizes.sizeOnTap! / 2,
                    color: AppColors.whiteColor,
                  ),
                ),
                Expanded(
                  child: widget.titleWidget ?? Text(
                    widget.title ?? "",
                    style: widget.titleStyle ?? AppTextStyles.style20BlackBold.copyWith(
                        fontSize: widget.titleSize ?? AppSizes.sizeOnTap! / 2,
                        color: AppColors.primaryColor
                    ),
                  ),
                ),
                widget.suffixTitle ?? Container(),
                if(_expand != null)
                  CustomRotateTransaction(
                    child: Icon(
                      Icons.keyboard_arrow_up,
                      size: widget.titleSize ?? AppSizes.sizeOnTap! / 2,
                      color: AppColors.grey500Color,
                    ),
                    open: _expand,
                  )
              ],
            ),
            widget.header??Container()
          ],
        ),
      ),
      onTap: (widget.title == null && widget.titleWidget == null)
          ? null
          : widget.onTitleTap ?? (_expand == null
          ? null
          : () {
        if(widget.onChanged != null){
          widget.onChanged!(!_expand!);
        }
        else{
          setState(() {
            _expand = !_expand!;
          });
        }
      }),
    );
  }

  Widget _buildContent() {
    if(_expand == null){
      return Container();
    }
    return CustomSizeTransaction(
      child: widget.child ?? Container(),
      open: _expand ?? false,
    );
  }

  Widget _buildBody() {
    return Container(
      color: widget.backgroundColor,
      child: Column(
        children: [_buildHeader(), _buildContent()],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }
}
