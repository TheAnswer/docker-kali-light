# Dockerfile kali-light

# Official base image
FROM kalilinux/kali-rolling

# Set working directory to /root
WORKDIR /root

# Apt
RUN apt -y update --fix-missing && apt -y upgrade && apt -y autoremove && apt clean

# Basic tools
RUN apt install aircrack-ng amap apt-utils bsdmainutils cewl crackmapexec crunch curl dirb dirbuster dnsenum dnsrecon dnsutils dos2unix enum4linux exploitdb ftp gcc git gobuster golang hashcat hping3 hydra impacket-scripts iputils-ping john joomscan libffi-dev make masscan metasploit-framework mimikatz nasm nbtscan ncat netcat-traditional nikto nmap onesixtyone patator php powershell powersploit proxychains python2 python3 python3-impacket python3-pip python3-setuptools python-dev python-setuptools recon-ng responder ruby-dev samba samdump2 seclists smbclient smbmap smtp-user-enum snmp socat sqlmap ssh-audit sslscan tcpdump testssl.sh theharvester vim wafw00f weevely wfuzz whatweb whois wordlists wpscan zsh -y --no-install-recommends

# Advanced tools
ADD ./install.sh /root/install.sh
RUN chmod +x /root/install.sh && /root/install.sh && rm /root/install.sh

# History (keep old history)
ADD ./conf/history /root/history
RUN cat /root/history >> /root/.zsh_history
RUN h=$(cat /root/.zsh_history | sort | uniq)
RUN echo $h > /root/.zsh_history
RUN rm /root/history

# Aliases
ADD ./conf/aliases /opt/aliases
RUN echo 'source /opt/aliases' >> /root/.zshrc

# Open shell
CMD ["/bin/zsh"]