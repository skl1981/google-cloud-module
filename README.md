# google-cloud-module

Created VM by gcloud with required properties

Command, which provides below conatins in cloudsdk.sh

![alt text](screenshots/1.png)


Created VM by terraform with required properties

All conf files have .tf and .tfvars extension in this repository

![alt text](screenshots/2.png)


Created VM by terraform with persistent disk and all required properties

.tf files uses dynamic external file (template) and different conditions

If -var created-way=gcp-terraform next resources will be created 

1) Standart persistent disk

2) Attached pd

3) VM with ext4 filesystem on attached pd 

![alt text](screenshots/3.png)


![alt text](screenshots/4.png) 
