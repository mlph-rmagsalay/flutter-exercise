import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CenterAppBar extends AppBar {
  CenterAppBar(final String title, final BuildContext context,
      {super.key,
      double elevation = 3,
      List<Widget>? actions,
      shouldShowLeading = true,
      SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle.dark,
      Function? backButton})
      : super(
            title: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 288),
              child: Text(
                title,
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: Colors.black.withOpacity(0.80),
                    fontSize: 22,
                    letterSpacing: 0.01),
              ),
            ),
            actions: actions,
            centerTitle: true,
            systemOverlayStyle: systemUiOverlayStyle,
            elevation: elevation,
            backgroundColor: Color.fromARGB(255, 204, 149, 226),
            leading: shouldShowLeading
                ? IconButton(
                    icon: Icon(Icons.chevron_left,
                        color: Colors.black.withOpacity(0.5), size: 28),
                    onPressed: () {
                      backButton != null
                          ? backButton()
                          : Navigator.pop(context);
                    },
                  )
                : Container());

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
