using PackageCompiler
create_sysimage([:Pluto, :PlutoUI];
                sysimage_path="/home/jovyan/sysimage.so",
                cpu_target = PackageCompiler.default_app_cpu_target())