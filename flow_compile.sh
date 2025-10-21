sudo docker run -w `pwd` -v `pwd`:`pwd` --rm -it quartus24.1 /24.1std/quartus/bin/quartus_sh --flow compile LEDs-racer.qpf -c DE0_NANO_LEDs_racer_main
