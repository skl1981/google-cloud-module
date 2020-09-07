To connect to a host on a private network, use the command:   ssh -i key -o "ProxyCommand ssh -W %h:%p -i key ubuntu@bastion-IP" ubuntu@target_host-IP
