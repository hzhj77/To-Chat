#!/bin/sh
set -e

echo "mkdir -p ${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
mkdir -p "${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"

SWIFT_STDLIB_PATH="${DT_TOOLCHAIN_DIR}/usr/lib/swift/${PLATFORM_NAME}"

install_framework()
{
  if [ -r "${BUILT_PRODUCTS_DIR}/$1" ]; then
    local source="${BUILT_PRODUCTS_DIR}/$1"
  else
    local source="${BUILT_PRODUCTS_DIR}/$(basename "$1")"
  fi

  local destination="${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"

  if [ -L "${source}" ]; then
      echo "Symlinked..."
      source="$(readlink "${source}")"
  fi

  # use filter instead of exclude so missing patterns dont' throw errors
  echo "rsync -av --filter \"- CVS/\" --filter \"- .svn/\" --filter \"- .git/\" --filter \"- .hg/\" --filter \"- Headers\" --filter \"- PrivateHeaders\" --filter \"- Modules\" \"${source}\" \"${destination}\""
  rsync -av --filter "- CVS/" --filter "- .svn/" --filter "- .git/" --filter "- .hg/" --filter "- Headers" --filter "- PrivateHeaders" --filter "- Modules" "${source}" "${destination}"

  # Resign the code if required by the build settings to avoid unstable apps
  code_sign_if_enabled "${destination}/$(basename "$1")"

  # Embed linked Swift runtime libraries
  local basename
  basename="$(basename "$1" | sed -E s/\\..+// && exit ${PIPESTATUS[0]})"
  local swift_runtime_libs
  swift_runtime_libs=$(xcrun otool -LX "${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}/${basename}.framework/${basename}" | grep --color=never @rpath/libswift | sed -E s/@rpath\\/\(.+dylib\).*/\\1/g | uniq -u  && exit ${PIPESTATUS[0]})
  for lib in $swift_runtime_libs; do
    echo "rsync -auv \"${SWIFT_STDLIB_PATH}/${lib}\" \"${destination}\""
    rsync -auv "${SWIFT_STDLIB_PATH}/${lib}" "${destination}"
    code_sign_if_enabled "${destination}/${lib}"
  done
}

# Signs a framework with the provided identity
code_sign_if_enabled() {
  if [ -n "${EXPANDED_CODE_SIGN_IDENTITY}" -a "${CODE_SIGNING_REQUIRED}" != "NO" -a "${CODE_SIGNING_ALLOWED}" != "NO" ]; then
    # Use the current code_sign_identitiy
    echo "Code Signing $1 with Identity ${EXPANDED_CODE_SIGN_IDENTITY_NAME}"
    echo "/usr/bin/codesign --force --sign ${EXPANDED_CODE_SIGN_IDENTITY} --preserve-metadata=identifier,entitlements \"$1\""
    /usr/bin/codesign --force --sign ${EXPANDED_CODE_SIGN_IDENTITY} --preserve-metadata=identifier,entitlements "$1"
  fi
}


if [[ "$CONFIGURATION" == "Debug" ]]; then
  install_framework 'Pods/AFNetworking.framework'
  install_framework 'Pods/APParallaxHeader.framework'
  install_framework 'Pods/BlocksKit.framework'
  install_framework 'Pods/FontAwesome_iOS.framework'
  install_framework 'Pods/JDStatusBarNotification.framework'
  install_framework 'Pods/JazzHands.framework'
  install_framework 'Pods/MBProgressHUD.framework'
  install_framework 'Pods/MMMarkdown.framework'
  install_framework 'Pods/MarqueeLabel.framework'
  install_framework 'Pods/Masonry.framework'
  install_framework 'Pods/NYXImagesKit.framework'
  install_framework 'Pods/ODRefreshControl.framework'
  install_framework 'Pods/POP_MCAnimate.framework'
  install_framework 'Pods/PPiAwesomeButton.framework'
  install_framework 'Pods/RBBAnimation.framework'
  install_framework 'Pods/RDVTabBarController.framework'
  install_framework 'Pods/ReactiveCocoa.framework'
  install_framework 'Pods/RegexKitLite_NoWarning.framework'
  install_framework 'Pods/SDCAlertView.framework'
  install_framework 'Pods/SDCAutoLayout.framework'
  install_framework 'Pods/SDWebImage.framework'
  install_framework 'Pods/SMPageControl.framework'
  install_framework 'Pods/SSKeychain.framework'
  install_framework 'Pods/SVPullToRefresh.framework'
  install_framework 'Pods/TPKeyboardAvoiding.framework'
  install_framework 'Pods/TTTAttributedLabel.framework'
  install_framework 'Pods/UIImage_BlurredFrame.framework'
  install_framework 'Pods/hpple.framework'
  install_framework 'Pods/iVersion.framework'
  install_framework 'Pods/pop.framework'
fi
if [[ "$CONFIGURATION" == "Release" ]]; then
  install_framework 'Pods/AFNetworking.framework'
  install_framework 'Pods/APParallaxHeader.framework'
  install_framework 'Pods/BlocksKit.framework'
  install_framework 'Pods/FontAwesome_iOS.framework'
  install_framework 'Pods/JDStatusBarNotification.framework'
  install_framework 'Pods/JazzHands.framework'
  install_framework 'Pods/MBProgressHUD.framework'
  install_framework 'Pods/MMMarkdown.framework'
  install_framework 'Pods/MarqueeLabel.framework'
  install_framework 'Pods/Masonry.framework'
  install_framework 'Pods/NYXImagesKit.framework'
  install_framework 'Pods/ODRefreshControl.framework'
  install_framework 'Pods/POP_MCAnimate.framework'
  install_framework 'Pods/PPiAwesomeButton.framework'
  install_framework 'Pods/RBBAnimation.framework'
  install_framework 'Pods/RDVTabBarController.framework'
  install_framework 'Pods/ReactiveCocoa.framework'
  install_framework 'Pods/RegexKitLite_NoWarning.framework'
  install_framework 'Pods/SDCAlertView.framework'
  install_framework 'Pods/SDCAutoLayout.framework'
  install_framework 'Pods/SDWebImage.framework'
  install_framework 'Pods/SMPageControl.framework'
  install_framework 'Pods/SSKeychain.framework'
  install_framework 'Pods/SVPullToRefresh.framework'
  install_framework 'Pods/TPKeyboardAvoiding.framework'
  install_framework 'Pods/TTTAttributedLabel.framework'
  install_framework 'Pods/UIImage_BlurredFrame.framework'
  install_framework 'Pods/hpple.framework'
  install_framework 'Pods/iVersion.framework'
  install_framework 'Pods/pop.framework'
fi
