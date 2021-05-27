variable "profile" {
  default = "default"
}

variable "region" {
  default = "ap-southeast-1"
}

variable "tf_backend" {
  default = "tflab-backend"
}

variable "default_tags" {
  type = map(string)
  default = {
		Owner	=	"anh.dinhtuan1"
		Environment	=	"tf-demo"
  }
}