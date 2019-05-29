# AnyKernel2 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() {
kernel.string=Optimus Drunk Kernel by GtrCraft
do.devicecheck=1
do.modules=0
do.cleanup=1
do.cleanuponabort=0
device.name1=beryllium
device.name2=PocoF1
device.name3=
device.name4=
device.name5=
supported.versions=
} # end properties

# shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;

## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;

# Display if using MIUI or a custom ROM
is_miui="$(file_getprop /system/build.prop 'ro.miui.ui.version.code')"
if [[ -z $is_miui ]]; then
    ui_print "You are running a custom ROM!"
else
    ui_print "You are running MIUI!"
fi

## AnyKernel install
dump_boot;

write_boot;

## end install

