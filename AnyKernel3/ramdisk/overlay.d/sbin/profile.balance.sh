#!/system/bin/sh

# Balance
echo "schedutil" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor 
echo "schedutil" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor 
echo "1766400" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq 
echo "2803200" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq 
echo "1056000" > /sys/module/cpu_input_boost/parameters/input_boost_freq_lp
echo "902400" > /sys/module/cpu_input_boost/parameters/input_boost_freq_hp 
echo "64" > /sys/module/cpu_input_boost/parameters/input_boost_duration 
echo "msm-adreno-tz" > /sys/class/kgsl/kgsl-3d0/devfreq/governor
echo "0" > /sys/class/kgsl/kgsl-3d0/devfreq/adrenoboost
