#!/system/bin/sh

# Battery
echo "blu_schedutil" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor 
echo "blu_schedutil" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor 
echo "1516800" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq 
echo "1056000" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq 
echo "825600" > /sys/module/cpu_input_boost/parameters/input_boost_freq_lp
echo "0" > /sys/module/cpu_input_boost/parameters/input_boost_freq_hp 
echo "32" > /sys/module/cpu_input_boost/parameters/input_boost_duration 
echo "powersave" > /sys/class/kgsl/kgsl-3d0/devfreq/governor
echo "0" > /sys/class/kgsl/kgsl-3d0/devfreq/adrenoboost
