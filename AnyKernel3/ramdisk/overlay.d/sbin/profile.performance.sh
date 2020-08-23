#!/system/bin/sh

# Performance
echo "schedutil" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor 
echo "schedutil" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor 
echo "1766400" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq 
echo "2803200" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq 
echo "1516800" > /sys/module/cpu_input_boost/parameters/input_boost_freq_lp
echo "1363200" > /sys/module/cpu_input_boost/parameters/input_boost_freq_hp 
echo "128" > /sys/module/cpu_input_boost/parameters/input_boost_duration 
echo "msm-adreno-tz" > /sys/class/kgsl/kgsl-3d0/devfreq/governor
echo "1" > /sys/class/kgsl/kgsl-3d0/devfreq/adrenoboost
