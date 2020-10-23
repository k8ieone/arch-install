#!/bin/bash

# Usage: ./s886_headless.sh $_USERNAME

# Splash
echo "   _____      _______ _____ ____  __  __  ___   ___    __  "
echo "  / ____|  /\|__   __/ ____/ __ \|  \/  |/ _ \ / _ \  / /  "
echo " | (___   /  \  | | | |   | |  | | \  / | (_) | (_) |/ /_  "
echo "  \___ \ / /\ \ | | | |   | |  | | |\/| |> _ < > _ <| '_ \ "
echo "  ____) / ____ \| | | |___| |__| | |  | | (_) | (_) | (_) |"
echo " |_____/_/    \_\_|  \_____\____/|_|  |_|\___/ \___/ \___/ "
echo "                                                           "
echo "                                                           "
echo

# Install Netdata and BOINC
pacman -S --noconfirm boinc-nox netdata thefuck neofetch

# Set BOINC password and enable remote access
echo "<cc_config>" > /var/lib/boinc/cc_config.xml
echo "    <options>" >> /var/lib/boinc/cc_config.xml
echo "       <use_all_gpus>1</use_all_gpus>" >> /var/lib/boinc/cc_config.xml
echo "       <allow_remote_gui_rpc>1</allow_remote_gui_rpc>" >> /var/lib/boinc/cc_config.xml
echo "    </options>" >> /var/lib/boinc/cc_config.xml
echo "</cc_config>" >> /var/lib/boinc/cc_config.xml
echo "a" > /var/lib/boinc/gui_rpc_auth.cfg
chown boinc:boinc /var/lib/boinc/cc_config.xml
chown boinc:boinc /var/lib/boinc/gui_rpc_auth.cfg

# Set BOINC's settings
echo "<global_preferences>" > /var/lib/boinc/global_prefs_override.xml
echo "   <run_on_batteries>1</run_on_batteries>" >> /var/lib/boinc/global_prefs_override.xml
echo "  <run_if_user_active>1</run_if_user_active>" >> /var/lib/boinc/global_prefs_override.xml
echo "  <run_gpu_if_user_active>1</run_gpu_if_user_active>" >> /var/lib/boinc/global_prefs_override.xml
echo "  <suspend_cpu_usage>0.000000</suspend_cpu_usage>" >> /var/lib/boinc/global_prefs_override.xml
echo "  <start_hour>0.000000</start_hour>" >> /var/lib/boinc/global_prefs_override.xml
echo "  <end_hour>0.000000</end_hour>" >> /var/lib/boinc/global_prefs_override.xml
echo "  <net_start_hour>0.000000</net_start_hour>" >> /var/lib/boinc/global_prefs_override.xml
echo "  <net_end_hour>0.000000</net_end_hour>" >> /var/lib/boinc/global_prefs_override.xml
echo "  <leave_apps_in_memory>0</leave_apps_in_memory>" >> /var/lib/boinc/global_prefs_override.xml
echo "  <confirm_before_connecting>0</confirm_before_connecting>" >> /var/lib/boinc/global_prefs_override.xml
echo "  <hangup_if_dialed>0</hangup_if_dialed>" >> /var/lib/boinc/global_prefs_override.xml
echo "  <dont_verify_images>0</dont_verify_images>" >> /var/lib/boinc/global_prefs_override.xml
echo "  <work_buf_min_days>0.100000</work_buf_min_days>" >> /var/lib/boinc/global_prefs_override.xml
echo "  <work_buf_additional_days>0.500000</work_buf_additional_days>" >> /var/lib/boinc/global_prefs_override.xml
echo "  <max_ncpus_pct>100.000000</max_ncpus_pct>" >> /var/lib/boinc/global_prefs_override.xml
echo "  <cpu_scheduling_period_minutes>60.000000</cpu_scheduling_period_minutes>" >> /var/lib/boinc/global_prefs_override.xml
echo "  <disk_interval>60.000000</disk_interval>" >> /var/lib/boinc/global_prefs_override.xml
echo "  <disk_max_used_gb>0.000000</disk_max_used_gb>" >> /var/lib/boinc/global_prefs_override.xml
echo "  <disk_max_used_pct>10.000000</disk_max_used_pct>" >> /var/lib/boinc/global_prefs_override.xml
echo "  <disk_min_free_gb>0.000000</disk_min_free_gb>" >> /var/lib/boinc/global_prefs_override.xml
echo "  <vm_max_used_pct>75.000000</vm_max_used_pct>" >> /var/lib/boinc/global_prefs_override.xml
echo "  <ram_max_used_busy_pct>75.000000</ram_max_used_busy_pct>" >> /var/lib/boinc/global_prefs_override.xml
echo "  <ram_max_used_idle_pct>75.000000</ram_max_used_idle_pct>" >> /var/lib/boinc/global_prefs_override.xml
echo "  <max_bytes_sec_up>0.000000</max_bytes_sec_up>" >> /var/lib/boinc/global_prefs_override.xml
echo "  <max_bytes_sec_down>0.000000</max_bytes_sec_down>" >> /var/lib/boinc/global_prefs_override.xml
echo "  <cpu_usage_limit>100.000000</cpu_usage_limit>" >> /var/lib/boinc/global_prefs_override.xml
echo "  <daily_xfer_limit_mb>0.000000</daily_xfer_limit_mb>" >> /var/lib/boinc/global_prefs_override.xml
echo "  <daily_xfer_period_days>0</daily_xfer_period_days>" >> /var/lib/boinc/global_prefs_override.xml
echo "</global_preferences>" >> /var/lib/boinc/global_prefs_override.xml
chown boinc:boinc /var/lib/boinc/global_prefs_override.xml

# Enable Netdata and BOINC
systemctl enable boinc-client.service netdata.service

# Add the netdata user to the boinc group
gpasswd -a netdata boinc

# Install and setup oh-my-zsh
# yay -S zsh-autosuggestions-git
sudo -u $1 yay --answerdiff "n" --mflags "--noconfirm" --batchinstall -S oh-my-zsh-git zsh-theme-powerlevel10k-git zsh-fast-syntax-highlighting-git
## Build a .zshrc file
echo "ZSH=/usr/share/oh-my-zsh/" > /tmp/zshrc
echo "source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme" >> /tmp/zshrc
# echo "source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" >> /tmp/zsrhc
echo "source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh" >> /tmp/zshrc
echo "POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true" >> /tmp/zshrc
echo "DISABLE_AUTO_UPDATE=\"true\"" >> /tmp/zshrc
echo "plugins=(git ssh-agent archlinux systemd)" >> /tmp/zshrc
echo "ZSH_CACHE_DIR=\$HOME/.cache/oh-my-zsh" >> /tmp/zshrc
echo "if [[ ! -d \$ZSH_CACHE_DIR ]]; then" >> /tmp/zshrc
echo "  mkdir \$ZSH_CACHE_DIR" >> /tmp/zshrc
echo "fi" >> /tmp/zshrc
echo "source \$ZSH/oh-my-zsh.sh" >> /tmp/zshrc
echo "PATH=\$PATH:~/.local/bin" >> /tmp/zshrc
echo "eval \$(thefuck --alias)" >> /tmp/zshrc
echo "EDITOR=nano" >> /tmp/zshrc
echo "neofetch" >> /tmp/zshrc
## Copy the file into the user's home
install -m 644 /tmp/zshrc /home/$1/.zshrc
chown $1:$1 /home/$1/.zshrc
## Change the user's default shell to zsh
chsh -s /bin/zsh $1
