# Notes from Terraform Deployment

### Assigning gvariables within modules
* Variables for different modules defined within _**./main.tf**_ need to have same name as the variables defined inside the module's _**./compute/main.tf**_.
* Variables defined in _**./variables.tf**_ to be used within _**./main.tf**_ can be named arbitratily.
	```
	module "compute" {
	  source = "./compute"
	  instance_count = "${var.instance_count}"
	  private_key_name = "${var.private_key_name}"
	  public_key_path = "${var.public)public_key_path}"
	  instance_type = "${var.server_instance_type}"
	}
	```
  * `instance_type` needs to be the same name as defined within _**./compute/main.tf**_.
  * `${var.server_instance_type}` is whatever you define in _**./variables.tf**_.
