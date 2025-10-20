FROM archlinux

WORKDIR .

ADD ./qinst-lite-linux-24.1std-1077.run .

RUN ./qinst-lite-linux-24.1std-1077.run --target install_dir --noexec

RUN pacman --noconfirm -Sy fontconfig

RUN ./install_dir/qinst.sh --cli --download-dir ./install_dir/quartus

RUN ./install_dir/quartus/QuartusLiteSetup-24.1std.0.1077-linux.run --mode unattended --installdir 24.1std --accept_eula 1
