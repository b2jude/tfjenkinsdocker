variable "zone_id" {

description ="(Required) The ID of the hosted zone output in module private zone"

}

variable "name"{

  description = "(Required) The name of the record."

}

variable "type" {

  description = "(Required) The record type. Valid values are A, AAAA, CAA, CNAME, MX, NAPTR, NS, PTR, SOA, SPF, SRV and TXT"

  default = "CNAME"

}

variable "ttl" {

  description = "(Required for non-alias records) The TTL of the record."

  default = 300

}



variable "records" {

    default     = []

    description = "(Required for non-alias records) A string list of records."

    type = "list"

}

variable "alb_dns_name" {}



variable "function" {

description = "In SP code, function is a name indicates the role of the application being developed ex: server"

}



  variable "zone_name" {

    description = "The name of zone output in module private zone"

  }
