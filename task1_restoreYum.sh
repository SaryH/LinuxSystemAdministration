sudo yum-config-manager --disable \*
sudo yum-config-manager --enable base/7/x86_64
sudo yum-config-manager --enable extras/7/x86_64
sudo yum-config-manager --enable updates/7/x86_64
sudo yum clean all && sudo yum makecache
echo "Done"
