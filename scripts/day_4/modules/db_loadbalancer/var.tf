variable "instance_group_name_private" {
    description     = "A unique name for the private group of resources."
    default         = "test-group-private"
}

variable "region" {
  description       = "Optional) A reference to the region where the regional forwarding rule resides. This field is not applicable to global forwarding rules."
  default           = "us-central1"
}

variable "ports" {
	description     = "(Optional) This field is used along with the backend_service field for internal load balancing. When the load balancing scheme is INTERNAL, a single port or a comma separated list of ports can be configured. Only packets addressed to these ports will be forwarded to the backends configured with this forwarding rule. You may specify a maximum of up to 5 ports."
	default         = ["5432"]
}

variable "network" {
    description     = "(Optional) For internal load balancing, this field identifies the network that the load balanced IP should belong to for this Forwarding Rule. If this field is not specified, the default network will be used. This field is only used for INTERNAL load balancing."
    default         = "vpc-network"
}

variable "private_subnet" {
    description     = "(Optional) The subnetwork that the load balanced IP should belong to for this Forwarding Rule. This field is only used for INTERNAL load balancing. If the network specified is in auto subnet mode, this field is optional. However, if the network is in custom subnet mode, a subnetwork must be specified."
    default         = "private-subnet"
}

variable "project" {
    description     = "(Optional) The ID of the project in which the resource belongs. If it is not provided, the provider project is used."
    default         = "exit-task1"
}
