part of widget;

class CustomSearchBox extends StatelessWidget {

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hint;
  final GestureTapCallback? onSearch;
  final Function(String)? onChanged;
  final EdgeInsetsGeometry? padding;
  final String? suffixIcon;
  final GestureTapCallback? onSuffixTap;

  const CustomSearchBox({
    Key? key,
    this.controller,
    this.focusNode,
    this.hint,
    this.onSearch,
    this.onChanged,
    this.padding, this.suffixIcon, this.onSuffixTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:padding ?? EdgeInsets.only(
        top: AppSizes.maxPadding ?? 0.0,
        right: AppSizes.maxPadding ?? 0.0,
        left: AppSizes.maxPadding ?? 0.0),
      child: CustomTextField(
        focusNode: focusNode,
        controller: controller,
        hintText: hint ?? AppLocalizations.text(LangKey.enter_search_information),
        backgroundColor: Colors.transparent,
        borderColor: AppColors.borderColor,
        suffixIcon: suffixIcon ?? Assets.iconSearch,
        onSuffixTap: onSuffixTap ?? onSearch,
        textInputAction: TextInputAction.search,
        onSubmitted: onSearch == null ? null : (_) => onSearch!(),
        onChanged: onChanged,
      ),
    );
  }
}
