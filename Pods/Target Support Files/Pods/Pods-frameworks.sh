#!/bin/sh
set -e

echo "mkdir -p ${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
mkdir -p "${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"

SWIFT_STDLIB_PATH="${DT_TOOLCHAIN_DIR}/usr/lib/swift/${PLATFORM_NAME}"

install_framework()
{
  local source="${BUILT_PRODUCTS_DIR}/Pods/$1"
  local destination="${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"

  if [ -L "${source}" ]; then
      echo "Symlinked..."
      source=$(readlink "${source}")
  fi

  # use filter instead of exclude so missing patterns dont' throw errors
  echo "rsync -av --filter "- CVS/" --filter "- .svn/" --filter "- .git/" --filter "- .hg/" --filter "- Headers/" --filter "- PrivateHeaders/" ${source} ${destination}"
  rsync -av --filter "- CVS/" --filter "- .svn/" --filter "- .git/" --filter "- .hg/" --filter "- Headers/" --filter "- PrivateHeaders/" "${source}" "${destination}"
  # Resign the code if required by the build settings to avoid unstable apps
  if [ "${CODE_SIGNING_REQUIRED}" == "YES" ]; then
      code_sign "${destination}/$1"
  fi

  # Embed linked Swift runtime libraries
  local basename
  basename=$(echo $1 | sed -E s/\\..+// && exit ${PIPESTATUS[0]})
  local swift_runtime_libs
  swift_runtime_libs=$(xcrun otool -LX "${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}/$1/${basename}" | grep --color=never @rpath/libswift | sed -E s/@rpath\\/\(.+dylib\).*/\\1/g | uniq -u  && exit ${PIPESTATUS[0]})
  for lib in $swift_runtime_libs; do
    echo "rsync -auv \"${SWIFT_STDLIB_PATH}/${lib}\" \"${destination}\""
    rsync -auv "${SWIFT_STDLIB_PATH}/${lib}" "${destination}"
    if [ "${CODE_SIGNING_REQUIRED}" == "YES" ]; then
      code_sign "${destination}/${lib}"
    fi
  done
}

# Signs a framework with the provided identity
code_sign() {
  # Use the current code_sign_identitiy
  echo "Code Signing $1 with Identity ${EXPANDED_CODE_SIGN_IDENTITY_NAME}"
  echo "/usr/bin/codesign --force --sign ${EXPANDED_CODE_SIGN_IDENTITY} --preserve-metadata=identifier,entitlements $1"
  /usr/bin/codesign --force --sign ${EXPANDED_CODE_SIGN_IDENTITY} --preserve-metadata=identifier,entitlements "$1"
}


if [[ "$CONFIGURATION" == "Debug" ]]; then
  install_framework 'AFNetworking.framework'
  install_framework 'APParallaxHeader.framework'
  install_framework 'AVOSCloud.framework'
  install_framework 'BlocksKit.framework'
  install_framework 'FontAwesome_iOS.framework'
  install_framework 'JDStatusBarNotification.framework'
  install_framework 'JazzHands.framework'
  install_framework 'MBProgressHUD.framework'
  install_framework 'MMMarkdown.framework'
  install_framework 'MarqueeLabel.framework'
  install_framework 'Masonry.framework'
  install_framework 'NYXImagesKit.framework'
  install_framework 'ODRefreshControl.framework'
  install_framework 'POP_MCAnimate.framework'
  install_framework 'PPiAwesomeButton.framework'
  install_framework 'RBBAnimation.framework'
  install_framework 'RDVTabBarController.framework'
  install_framework 'ReactiveCocoa.framework'
  install_framework 'RegexKitLite_NoWarning.framework'
  install_framework 'SDCAlertView.framework'
  install_framework 'SDCAutoLayout.framework'
  install_framework 'SDWebImage.framework'
  install_framework 'SMPageControl.framework'
  install_framework 'SSKeychain.framework'
  install_framework 'SVPullToRefresh.framework'
  install_framework 'TPKeyboardAvoiding.framework'
  install_framework 'TTTAttributedLabel.framework'
  install_framework 'UIImage_BlurredFrame.framework'
  install_framework 'hpple.framework'
  install_framework 'iVersion.framework'
  install_framework 'pop.framework'
fi
if [[ "$CONFIGURATION" == "Release" ]]; then
  install_framework 'AFNetworking.framework'
  install_framework 'APParallaxHeader.framework'
  install_framework 'AVOSCloud.framework'
  install_framework 'BlocksKit.framework'
  install_framework 'FontAwesome_iOS.framework'
  install_framework 'JDStatusBarNotification.framework'
  install_framework 'JazzHands.framework'
  install_framework 'MBProgressHUD.framework'
  install_framework 'MMMarkdown.framework'
  install_framework 'MarqueeLabel.framework'
  install_framework 'Masonry.framework'
  install_framework 'NYXImagesKit.framework'
  install_framework 'ODRefreshControl.framework'
  install_framework 'POP_MCAnimate.framework'
  install_framework 'PPiAwesomeButton.framework'
  install_framework 'RBBAnimation.framework'
  install_framework 'RDVTabBarController.framework'
  install_framework 'ReactiveCocoa.framework'
  install_framework 'RegexKitLite_NoWarning.framework'
  install_framework 'SDCAlertView.framework'
  install_framework 'SDCAutoLayout.framework'
  install_framework 'SDWebImage.framework'
  install_framework 'SMPageControl.framework'
  install_framework 'SSKeychain.framework'
  install_framework 'SVPullToRefresh.framework'
  install_framework 'TPKeyboardAvoiding.framework'
  install_framework 'TTTAttributedLabel.framework'
  install_framework 'UIImage_BlurredFrame.framework'
  install_framework 'hpple.framework'
  install_framework 'iVersion.framework'
  install_framework 'pop.framework'
fi