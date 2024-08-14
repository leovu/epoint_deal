part of widget;

class CustomQuantity extends StatelessWidget {
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;

  const CustomQuantity(
      {Key? key, this.focusNode, this.controller, this.onChanged, this.inputFormatters})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      focusNode: focusNode,
      controller: controller,
      hintText: formatMoney(defaultCartQuantity),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      backgroundColor: Colors.transparent,
      borderColor: AppColors.borderColor,
      inputFormatters: inputFormatters ?? [
        // if((Globals.model?.decimalNumber ?? 0) == 0)
        //   ...[
        //     FilteringTextInputFormatter.digitsOnly,
        //     FormatNumberInputFormatter(AppFormat.quantityFormat),
        //   ]
        // else
        //   DecimalNumberInputFormatter(decimalNumber: Globals.model?.decimalNumber),

      ],
      onChanged: onChanged,
    );
  }
}

class CustomPrice extends StatelessWidget {
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final double? newPrice;
  final Function(String)? onChanged;
  final String? hint;

  const CustomPrice(
      {Key? key,
      this.focusNode,
      this.controller,
      this.newPrice,
      this.onChanged,
      this.hint})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(Global.isDisabledPrice == 1){
      return Text(
        "${formatMoney(newPrice)} $moneyUnit",
        style: AppTextStyles.style14BlackNormal,
      );
    }
    return CustomTextField(
      focusNode: focusNode,
      controller: controller,
      suffixText: moneyUnit,
      hintText: hint ?? formatMoney(newPrice),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      backgroundColor: Colors.transparent,
      borderColor: AppColors.borderColor,
      inputFormatters: [
        if((Global.decimalNumber ?? 0) == 0)
          ...[
            FilteringTextInputFormatter.digitsOnly,
            FormatNumberInputFormatter(AppFormat.quantityFormat),
          ]
        else
          DecimalNumberInputFormatter(decimalNumber: Global.decimalNumber)
      ],
      onChanged: onChanged,
    );
  }
}

class CustomNote extends StatelessWidget {
  final FocusNode? focusNode;
  final TextEditingController? controller;

  const CustomNote({Key? key, this.focusNode, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      focusNode: focusNode,
      controller: controller,
      maxLines: 3,
      hintText: AppLocalizations.text(LangKey.note_information),
      backgroundColor: Colors.transparent,
      borderColor: AppColors.borderColor,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
    );
  }
}
