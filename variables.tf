variable "profile" {
  type = string
  default = "default"
}

variable "region" {
  type = string
}

variable "tf_backend" {
  type = string
}

variable "default_tags" {
  type = map(string)
  default = {
		Project	=	"demo"
		Environment	=	"demo"
  }
}