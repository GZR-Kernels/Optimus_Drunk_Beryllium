#!/bin/bash

#set -e

## Copy this script inside the kernel directory
KERNEL_DIR=$PWD
CLANG_TOOLCHAIN=$ANDROIDDIR/kernel/prebuilts/clang-6170260/bin/clang-10
KERNEL_TOOLCHAIN=$ANDROIDDIR/kernel/prebuilts/aarch64-linux-android-4.9/bin/aarch64-linux-android-
ARM32_TOOLCHAIN=$ANDROIDDIR/kernel/prebuilts/arm-linux-androideabi-4.9/bin/arm-linux-androideabi-
KERNEL_DEFCONFIG=beryllium_defconfig
ANY_KERNEL3_DIR=$KERNEL_DIR/AnyKernel3/
FINAL_KERNEL_ZIP=Optimus_Drunk_Beryllium_v10.5.zip
# Speed up build process
MAKE="./makeparallel"

BUILD_START=$(date +"%s")
blue='\033[0;34m'
cyan='\033[0;36m'
yellow='\033[0;33m'
red='\033[0;31m'
nocol='\033[0m'

echo "**** Setting Toolchain ****"
export CROSS_COMPILE=$KERNEL_TOOLCHAIN
export CROSS_COMPILE_ARM32=$ARM32_TOOLCHAIN
export ARCH=arm64
export SUBARCH=arm64
export KBUILD_COMPILER_STRING="Clang Version 10.0.2"

# Clean build always lol
echo "**** Cleaning ****"
mkdir -p out
make O=out clean

echo "**** Kernel defconfig is set to $KERNEL_DEFCONFIG ****"
echo -e "$blue***********************************************"
echo "          BUILDING KERNEL          "
echo -e "***********************************************$nocol"
make $KERNEL_DEFCONFIG O=out
make -j$(nproc --all) CC=$CLANG_TOOLCHAIN CLANG_TRIPLE=aarch64-linux-gnu- O=out

echo "**** Verify Image.gz-dtb ****"
ls $KERNEL_DIR/out/arch/arm64/boot/Image.gz-dtb

#Anykernel 2 time!!
echo "**** Verifying AnyKernel3 Directory ****"
ls $ANY_KERNEL3_DIR
echo "**** Removing leftovers ****"
rm -rf $ANY_KERNEL3_DIR/Image.gz-dtb
rm -rf $ANY_KERNEL3_DIR/$FINAL_KERNEL_ZIP

echo "**** Copying Image.gz-dtb ****"
cp $KERNEL_DIR/out/arch/arm64/boot/Image.gz-dtb $ANY_KERNEL3_DIR/

echo "**** Time to zip up! ****"
cd $ANY_KERNEL3_DIR/
zip -r9 $FINAL_KERNEL_ZIP * -x README $FINAL_KERNEL_ZIP
cp $KERNEL_DIR/AnyKernel3/$FINAL_KERNEL_ZIP $ANDROIDDIR/kernel/$FINAL_KERNEL_ZIP

echo "**** Done, here is your sha1 ****"
cd $KERNEL_DIR
rm -rf $ANY_KERNEL3_DIR/$FINAL_KERNEL_ZIP
rm -rf AnyKernel3/Image.gz-dtb
rm -rf $KERNEL_DIR/out/

BUILD_END=$(date +"%s")
DIFF=$(($BUILD_END - $BUILD_START))
echo -e "$yellow Build completed in $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds.$nocol"
sha1sum $ANDROIDDIR/kernel/$FINAL_KERNEL_ZIP
