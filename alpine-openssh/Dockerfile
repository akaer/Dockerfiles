#
# Docker image for
#
# openssh - use the openssh server from Alpine Linux
#
#
# Create:
#
# sudo docker build --rm -t akaer/alpssh . 2>&1 |tee docker_build.log
#
# Run:
#
#  sudo docker run --rm=true -it \
#  --name alpssh --hostname alpssh \
#  -v /etc/localtime:/etc/localtime:ro \
#  -p 2222:22 akaer/alpssh
#

FROM akaer/base
LABEL maintainer "André Raabe <andre.raabe@gmail.com>"

ENV PWDALGO sha512

RUN set -ex \
    && apk update \
    && apk add --no-cache \
        augeas \
        gzip \
        openssh-server-pam \
        shadow \
    && rm -rf /var/cache/apk/* \
    && usermod -s /bin/bash root \
    && echo 'root:P@ssw0rd' |chpasswd -m \
    && printf '%s\n' \
        'set /files/etc/ssh/sshd_config/Port 22' \
        'set /files/etc/ssh/sshd_config/PasswordAuthentication yes' \
        'set /files/etc/ssh/sshd_config/PermitRootLogin yes' \
        'set /files/etc/ssh/sshd_config/UseDNS no' | augtool -s \
    && printf '%s\n' \
        "#!/usr/bin/env bash" \
        "set -Eeuo pipefail" \
        "" \
        "print_fingerprints() {" \
        "    local BASE_DIR=\${1-'/etc/ssh'}" \
        "    for item in dsa rsa ecdsa ed25519; do" \
        "        echo \">>> Fingerprints for \${item} host key\"" \
        "        ssh-keygen -E md5 -lf \${BASE_DIR}/ssh_host_\${item}_key" \
        "        ssh-keygen -E sha256 -lf \${BASE_DIR}/ssh_host_\${item}_key" \
        "        ssh-keygen -E sha512 -lf \${BASE_DIR}/ssh_host_\${item}_key" \
        "    done" \
        "}" \
        "" \
        "ssh-keygen -A" \
        "print_fingerprints" \
        "echo \">>> Password encryption uses: \${PWDALGO}\"" \
        "sed -i \"s|sha512|\${PWDALGO}|g\" /etc/pam.d/base-password" \
        "/usr/sbin/sshd -D -e -f /etc/ssh/sshd_config" >> /root/runscript.sh \
    && chmod +x /root/runscript.sh \
    && rm -f /etc/motd \
    && echo "export PS1='[\u@\h \W]\$ '" >/etc/profile.d/prompt.sh \
    && chmod +x /etc/profile.d/prompt.sh

EXPOSE 22

CMD [ "/bin/bash", "-c", "/root/runscript.sh" ]

