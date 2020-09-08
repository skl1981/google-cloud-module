
#---------------------------------------------------------------#
# Create terraform autoskalling of nginx instances              #
#---------------------------------------------------------------#

resource "google_compute_region_autoscaler" "public" {
    name                        = var.nginx_autoscalling
    target                      = google_compute_region_instance_group_manager.public.id

    autoscaling_policy {
         cooldown_period        = 60
         min_replicas           = 1
         max_replicas           = 3

    cpu_utilization {
         target                 = 0.6
    }
  }
}

#--------------------------------------------------------------#
# Create compute instance group in private subnet              #
#--------------------------------------------------------------#

resource "google_compute_region_instance_group_manager" "private" {
    name                        = var.instance_group_name_private
    base_instance_name          = var.base_name_group_private
    description                 = var.description_group_private
    region                      = var.region
    project                     = var.project
    distribution_policy_zones   = var.zones

    version {
        instance_template       = google_compute_instance_template.private.id
    }

    target_size                 = 3
    
    #auto_healing_policies {
    #    health_check            = google_compute_health_check.private-autohealing.id
    #   initial_delay_sec        = 300
    #}
}

#--------------------------------------------------------------#
# Create compute instance group in public subnet               #
#--------------------------------------------------------------#

resource "google_compute_region_instance_group_manager" "public" {
    name = var.instance_group_name_public
    base_instance_name = var.base_name_group_public
    description = var.description_group_public
    region = var.region
    project = var.project
    distribution_policy_zones = var.zones

    version {
        instance_template = google_compute_instance_template.public.id
    }
    
    #auto_healing_policies {
    #    health_check            = google_compute_health_check.public-autohealing.id
    #    initial_delay_sec       = 300
    #}
}

#------------------------------------------------------#
# Create compute instance template in private network  #
#------------------------------------------------------#

resource "google_compute_instance_template" "private" {

    name_prefix                 = var.name_private_template
    description                 = var.description_private_template

    project                     = var.project
    region                      = var.region
    machine_type                = var.machine_type

    can_ip_forward              = var.can_ip_forward_private

    network_interface {
        network                 = var.network
        subnetwork              = var.private_subnet
    }


    disk {
        auto_delete             = var.boot_disk_auto_delete
        boot                    = var.boot_disk_check
        device_name             = var.boot_disk_device_name
        disk_size_gb            = var.boot_disk_size
        disk_type               = var.boot_disk_type
        source_image            = "${var.image_project}/${var.image_family}"
    }


    metadata = {
        ssh-keys = "var.ssh_user:${file("key.pub")}"
    }

    metadata_startup_script     = file("./startup_private.sh")  


    tags                        = var.private_network_name_tags

    service_account {
        email                   = var.service_account_email
        scopes                  = var.service_account_scopes
    }

   #scheduling {
       # preemptible             = var.scheduling_preemptible
       # on_host_maintenance     = var.scheduling_on_host_maintenance
       # automatic_restart       = var.scheduling_automatic_restart
    #}
    
    #lifecycle {
    #    create_before_destroy = true
    #}

}


#------------------------------------------------------#
# Create compute instance template in public network   #
#------------------------------------------------------#

resource "google_compute_instance_template" "public" {

    name_prefix                 = var.name_public_template
    description                 = var.description_public_template

    project                     = var.project
    region                      = var.region
    machine_type                = var.machine_type

    can_ip_forward              = var.can_ip_forward_public

    network_interface {
        network                 = var.network
        subnetwork              = var.public_subnet 
    }


    disk {
        auto_delete             = var.boot_disk_auto_delete
        boot                    = var.boot_disk_check
        device_name             = var.boot_disk_device_name
        disk_size_gb            = var.boot_disk_size
        disk_type               = var.boot_disk_type
        source_image            = "${var.image_project}/${var.image_family}"
    }


    metadata = {
        ssh-keys = "var.ssh_user:${file("key.pub")}"
    }

    metadata_startup_script     = templatefile("startup_public.sh", { student_name = "${var.student_name}", student_surname = "${var.student_surname}"})  

    tags                        = var.public_network_name_tags

    service_account {
        email                   = var.service_account_email
        scopes                  = var.service_account_scopes
    }

    #scheduling {
        #preemptible             = var.scheduling_preemptible
        #on_host_maintenance     = var.scheduling_on_host_maintenance
        #automatic_restart        = var.scheduling_automatic_restart
    #}

    #lifecycle {
    #    create_before_destroy   = true
    #}
}

