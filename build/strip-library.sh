#!/bin/bash

#
# please run on macos
#

set -e
CURRENT_PATH=$PWD
PACKAGE_PATH=../Unity/Packages/games.cheetah.unity.grpc/Runtime/Platform

# mac os
strip -S -x -o $PACKAGE_PATH/osx/x64/grpc_csharp_ext.bundle.stripped $PACKAGE_PATH/osx/x64/grpc_csharp_ext.bundle
rm $PACKAGE_PATH/osx/x64/grpc_csharp_ext.bundle
mv $PACKAGE_PATH/osx/x64/grpc_csharp_ext.bundle.stripped $PACKAGE_PATH/osx/x64/grpc_csharp_ext.bundle

# ios
strip -S -x -T -o $PACKAGE_PATH/ios/libgrpc.a.stripped $PACKAGE_PATH/ios/libgrpc.a
rm $PACKAGE_PATH/ios/libgrpc.a
mv $PACKAGE_PATH/ios/libgrpc.a.stripped $PACKAGE_PATH/ios/libgrpc.a

# windows

# android - x86
cd $PACKAGE_PATH
cd android/x86
docker run -v ${PWD}:/mount/ dockcross/android-arm64:20210109-7e58f93  /usr/aarch64-linux-android/bin/i686-linux-android-strip  --strip-all /mount/libgrpc_csharp_ext.so
cd $CURRENT_PATH

# android - arm64
cd $PACKAGE_PATH
cd android/arm64-v8a
docker run -v ${PWD}:/mount/ dockcross/android-arm64:20210109-7e58f93  /usr/aarch64-linux-android/bin/aarch64-linux-android-strip  --strip-all /mount/libgrpc_csharp_ext.so
cd $CURRENT_PATH

# android - armeabi-v7a
cd $PACKAGE_PATH
cd android/armeabi-v7a
docker run -v ${PWD}:/mount/ dockcross/android-arm64:20210109-7e58f93  /usr/aarch64-linux-android/bin/arm-linux-androideabi-strip  --strip-all /mount/libgrpc_csharp_ext.so
cd $CURRENT_PATH

# linux
cd $PACKAGE_PATH
cd linux/x64
docker run -v $PWD:/mount/ gcc strip -s /mount/libgrpc_csharp_ext.so
cd $CURRENT_PATH
