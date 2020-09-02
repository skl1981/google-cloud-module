variable "createway" {
	default="terraform"
}
variable "machinetype" {
        default="custom-1-4608"
}
variable "zone" {
        default="us-central1-c"
}
variable "tags" {
        type=list
}
variable "labels" {
        type=map
}
variable "delprot" {
        type=bool
}
variable "testdisk" {
        type=string
}
variable "sizetestdisk" {
        type=string
}

