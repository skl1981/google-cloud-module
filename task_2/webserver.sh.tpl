function nginx {
sudo yum install -y nginx
cat << EOF > /usr/share/nginx/html/index.html
<html>
<h2>build by terraform</h2>
</html>
EOF
sudo systemctl start nginx
sudo systemctl enable nginx
}

if [ ${condition} == "terraform" ]
then
nginx
elif [ ${condition} == "gcp-terraform" ]
then
sudo mkdir /mnt/disk-${condition}
sudo mkfs.ext4 -F -E \
  lazy_itable_init=0,lazy_journal_init=0,discard \
  /dev/disk/by-id/scsi-0Google_PersistentDisk_persistent-disk-1
  sudo mount -o discard,defaults \
    /dev/disk/by-id/scsi-0Google_PersistentDisk_persistent-disk-1 \
    /mnt/disk-${condition}
sudo su -
echo \
  "/dev/disk/by-id/scsi-0Google_PersistentDisk_persistent-disk-1 /mnt/mydisk ext4 defaults 1 1" \
  >> /etc/fstab
nginx
fi
