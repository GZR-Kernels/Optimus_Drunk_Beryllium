#!/bin/bash

#set -e

DATE_POSTFIX=$(date +"%Y%m%d")

## Copy this script inside the kernel directory
KERNEL_DIR=$PWD
KERNEL_TOOLCHAIN=$ANDROIDDIR/kernel/prebuilts/aarch64-linux-gnu/bin/aarch64-linux-gnu-
CLANG_TOOLCHAIN=$ANDROIDDIR/kernel/prebuilts/clang-r353983c/bin/clang-9
ARM32_TOOLCHAIN=$ANDROIDDIR/kernel/prebuilts/arm-linux-androideabi-4.9/bin/arm-linux-androideabi-
KERNEL_DEFCONFIG=beryllium_defconfig
JOBS=16
ANY_KERNEL2_DIR=$KERNEL_DIR/AnyKernel2/
FINAL_KERNEL_ZIP=Optimus_Drunk_Beryllium-$DATE_POSTFIX.zip
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
export KBUILD_COMPILER_STRING="Clang Version 9.0.3"

# Clean build always lol
echo "**** Cleaning ****"
make clean && make mrproper && rm -rf out/

echo "**** Kernel defconfig is set to $KERNEL_DEFCONFIG ****"
echo -e "$blue***********************************************"
echo "          BUILDING KERNEL          "
echo -e "***********************************************$nocol"
make $KERNEL_DEFCONFIG O=out
make -j$JOBS CC=$CLANG_TOOLCHAIN CLANG_TRIPLE=aarch64-linux-gnu- O=out

echo "**** Verify Image.gz-dtb ****"
ls $KERNEL_DIR/out/arch/arm64/boot/Image.gz-dtb

#Anykernel 2 time!!
echo "**** Verifying Anykernel2 Directory ****"
ls $ANY_KERNEL2_DIR
echo "**** Removing leftovers ****"
rm -rf $ANY_KERNEL2_DIR/Image.gz-dtb
rm -rf $ANY_KERNEL2_DIR/$FINAL_KERNEL_ZIP

echo "**** Copying Image.gz-dtb ****"
cp $KERNEL_DIR/out/arch/arm64/boot/Image.gz-dtb $ANY_KERNEL2_DIR/

echo "**** Time to zip up! ****"
cd $ANY_KERNEL2_DIR/
zip -r9 $FINAL_KERNEL_ZIP * -x README $FINAL_KERNEL_ZIP
cp $KERNEL_DIR/AnyKernel2/$FINAL_KERNEL_ZIP $ANDROIDDIR/kernel/$FINAL_KERNEL_ZIP

echo "**** Good Bye!! ****"
cd $KERNEL_DIR
rm -rf $ANY_KERNEL2_DIR/$FINAL_KERNEL_ZIP
rm -rf AnyKernel2/Image.gz-dtb
rm -rf $KERNEL_DIR/out/

BUILD_END=$(date +"%s")
DIFF=$(($BUILD_END - $BUILD_START))
echo -e "$yellow Build completed in $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds.$nocol"
