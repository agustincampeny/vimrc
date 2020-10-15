#! /bin/sh

./configure --enable-multibyte \
--enable-perlinterp=dynamic \
--enable-rubyinterp=dynamic \
--enable-pythoninterp=dynamic \
--enable-python3interp=dynamic \
--enable-cscope \
--enable-gui=athena \
--with-features=huge \
--with-x \
--enable-fontset \
--enable-largefile \
--disable-netbeans \
--enable-fail-if-missing \
--disable-darwin \
--enable-autoservername
