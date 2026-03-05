FROM archlinux

RUN pacman --noconfirm -Sy fontconfig core/libxcrypt-compat

ADD ./qinst-lite-linux-25.1std-1129.run .

RUN ./qinst-lite-linux-25.1std-1129.run --target install_dir --noexec


RUN ./install_dir/qinst.sh --cli --download-dir ./install_quartus --components quartus,cyclone

RUN ./install_quartus/QuartusLiteSetup-25.1std.0.1129-linux.run --mode unattended --installdir 25.1std --accept_eula 1

ENTRYPOINT ["/25.1std/quartus/bin/quartus_sh"]
