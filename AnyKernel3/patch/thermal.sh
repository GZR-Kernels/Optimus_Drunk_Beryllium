#!/system/bin/sh
mount -o rw,remount /system

# custom thermal config (users can edit it!)
mount -o bind /system/etc/thermal-engine.conf /vendor/etc/thermal-engine.conf

# Custom thermal-engine
mount -o bind /system/bin/thermal-engine /vendor/bin/thermal-engine

mount -o ro,remount /system
