
/*####################################################################################
Always define the default provider when calling module
Define provider with  alias explicitly use in resource creation or data collection in main.tf

###################################################################################
*/

provider "aws" {
  region = "${var.region}"
  profile = "devaccount"
  alias = "dev.account"
}

/*####################################################################################
Define provider with no alias which is the default provider called by the module call in main.tf
module call in main.tf uses the default provider
###################################################################################
*/

provider "aws" {
  region = "${var.region}"
  profile = "devaccount"

}
